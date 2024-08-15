import 'package:flutter/material.dart';
import 'package:lara2/screens/stats_and_settings_screen.dart';
import 'quiz_screen.dart';
import 'setup.dart' as setup;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  bool developerMode = false;
  Color _buttonColor = Colors.grey;

  void _updateButtonColor() {
    setState(() {
      _buttonColor = _buttonColor == Colors.grey ? Colors.red : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordProtectedScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordProtectedScreen()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
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
                      builder: (context) => QuizScreen(index, developerMode),
                    ),
                  );
                },
                child: Text(setup.getChapterName(index)),
              ),
            );
          }),
        )),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              backgroundColor: _buttonColor,
              onPressed: () {
                developerMode = !developerMode;
                _updateButtonColor();

              },
              child: Icon(Icons.add),
              mini: true, // Makes the button small
            ),
          ),
        ],
      ),
    );
  }
}
