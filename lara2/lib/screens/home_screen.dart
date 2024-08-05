import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  final int amountOfCategories = 3; // Change this to the desired number of categories

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(amountOfCategories, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(index + 1),
                    ),
                  );
                },
                child: Text('Kategorie  ${index + 1}'),
              ),
            );
          }),
        ),
      ),
    );
  }
}
