import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'setup.dart' as setup;

class FinishScreen extends StatelessWidget {
  final int index;
  const FinishScreen(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Du hast Kategorie ${setup.getChapterName(index)} geschafft! Zeige das deiner Lehrkraft :)',
              style: const TextStyle(fontSize: 24),
            ),
            Expanded(
              child: Image.asset(
                "assets/images/done.png",
                fit: BoxFit.contain,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text('Zurück zur Auswahl'),
            ),
          ],
        ),
      ),
    );
  }
}
