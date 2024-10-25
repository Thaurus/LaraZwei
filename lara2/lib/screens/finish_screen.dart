
import 'dart:async';
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

  bool isFrozen = false;

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

    Timer(Duration(seconds: 10), () {
      setState(() {
        isFrozen = true;
      });
      _controller.stop(); // Stop the animation controller
    });

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              setup.getChapterTitle(widget.index),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
            ),
            SizedBox(
              height: 200,
              child: Image.asset(
                "assets/images/Done.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor:  Color(0xFF6D7881),
                elevation: 2.0,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => route.isFirst,
                );
              },
              child: const Text('Zurück zum Anfang', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
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