import 'package:flutter/material.dart';
import 'home_screen.dart';

class FinishScreen extends StatelessWidget {
  final int index;

  FinishScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                'Du hast Kategorie $index geschafft! Zeig das deiner Lehrkraft :)',
                style: TextStyle(fontSize: 24),
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
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Text('Zurück zur Auswahl'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
