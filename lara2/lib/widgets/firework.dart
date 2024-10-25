import 'package:flutter/material.dart';
import 'dart:math';

class Firework {
  final Offset position;
  final Color color;
  final List<Particle> particles;
  bool isFinished = false;

  Firework(Size screenSize)
      : position = Offset((Random().nextBool() ? Random().nextDouble() * screenSize.width*0.25 : Random().nextDouble() * screenSize.width*0.25 + screenSize.width*0.75), Random().nextDouble() * screenSize.height - screenSize.height/1.8),
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
            speed: Random().nextDouble() * 1 + 1,
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