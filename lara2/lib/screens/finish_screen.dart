
import 'dart:math';

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'setup.dart' as setup;
import 'package:lara2/globals.dart' as globals;

class FinishScreen extends StatefulWidget {
  final int index;
  const FinishScreen(this.index, {super.key});

  @override
  _FinishScreenState createState() => _FinishScreenState(this.index);
}


class Firework {
  final Offset position;
  final Color color;
  final List<Particle> particles;
  bool isFinished = false;

  Firework(Size screenSize)
      : position = Offset(
      Random().nextDouble() * screenSize.width,
      Random().nextDouble() * screenSize.height / 2),
        color = Color.fromARGB(
          255,
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
        ),
        particles = List.generate(
          100,
              (index) => Particle(
            direction: Random().nextDouble() * 2 * pi,
            speed: Random().nextDouble() * 2 + 1,
            color: Color.fromARGB(
              255,
              Random().nextInt(256),
              Random().nextInt(256),
              Random().nextInt(256),
            ),
          ),
        );

  void update() {
    for (var particle in particles) {
      particle.update();
    }
    isFinished = particles.every((particle) => particle.isFinished);
  }
}

class Particle {
  Offset position;
  final double direction;
  double speed;
  final Color color;
  double life = 2.0;
  bool isFinished = false;

  Particle({
    required this.direction,
    required this.speed,
    required this.color,
  }) : position = Offset.zero;

  void update() {
    if (life > 0) {
      position = Offset(
        position.dx + cos(direction) * speed,
        position.dy + sin(direction) * speed,
      );
      life -= 0.01;
      life = max(0.0, life);
    } else {
      isFinished = true;
    }
  }
}
class FireworkPainter extends CustomPainter {
  final List<Firework> fireworks;

  FireworkPainter(this.fireworks);

  @override
  void paint(Canvas canvas, Size size) {
    for (final firework in fireworks) {
      _drawFirework(canvas, size, firework);
    }
  }

  void _drawFirework(Canvas canvas, Size size, Firework firework) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    for (final particle in firework.particles) {
      paint.color = particle.color.withOpacity(particle.life.clamp(0.0, 1.0));
      canvas.drawCircle(
          firework.position + particle.position, 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



class _FinishScreenState extends State<FinishScreen> with SingleTickerProviderStateMixin{
  final int index;
  _FinishScreenState(this.index);

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
      duration: Duration(seconds: 3),
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
              'Du hast ${setup.getChapterTitle(index)} geschafft! Zeig das deiner Lehrkraft :)',
              style: TextStyle(fontSize: 24),
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
