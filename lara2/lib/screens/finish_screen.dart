
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lara2/widgets/firework.dart';
import 'home_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import '../setup/setup.dart' as setup;
import 'package:lara2/setup/globals.dart' as globals;

class FinishScreen extends StatefulWidget {
  final int index;
  const FinishScreen(this.index, {super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  final List<Firework> _fireworks = [];

  final AudioPlayer audioPlayer = AudioPlayer();
  late Size _screenSize;

  void playSound() async {
      await audioPlayer.play('assets/sounds/finish.mp3');
  }

  @override
  void initState() {
    super.initState();
    if(globals.playSound) playSound();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Defer initialization of fireworks until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenSize = MediaQuery.of(context).size;
        _initializeFireworks();
      });
    });
  }

  void _initializeFireworks() {
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          if (Random().nextDouble() < 0.1) {
            _fireworks.add(Firework(_screenSize));
          }
          for (var firework in _fireworks) {
            firework.update();
          }
          _fireworks.removeWhere((firework) => firework.isFinished);
        });
      }
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Du hast ${setup.getChapterTitle(widget.index)} geschafft! Zeig das deiner Lehrkraft :)',
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => route.isFirst,
                );
              },
              child: const Text('Zurück zur Auswahl'),
            ),
          CustomPaint(
          painter: FireworkPainter(_fireworks),
          child: Container(),
        )
        
        ]
                ),
      ),
    );
  }
}