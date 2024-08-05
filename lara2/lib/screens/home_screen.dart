import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'setup.dart' as setup;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(setup.images.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(index),
                    ),
                  );
                },
                child: Text(setup.getChapterName(index)),
              ),
            );
          }),
        ),
      ),
    );
  }
}
