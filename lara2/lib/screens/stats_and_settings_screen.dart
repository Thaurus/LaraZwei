import 'package:flutter/material.dart';

class StatsAndSettingsScreen extends StatefulWidget {
  const StatsAndSettingsScreen({super.key});

  @override
  State<StatsAndSettingsScreen> createState() => _StatsAndSettingsScreenState();
}

class _StatsAndSettingsScreenState extends State<StatsAndSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Statistiken und Einstellungen'),
        bottom: const TabBar(
        tabs: [
          Tab(text: 'Statistiken'),
          Tab(text: 'Einstellungen'),
        ],
        ),
      ),
      body: TabBarView(
        children: [
        Center(
          child: Text('Stats'),
        ),
        Center(
          child: Text('Settings'),
        ),
        ],
      ),
      ),
    );
  }
}

class PasswordProtectedScreen extends StatefulWidget {
  const PasswordProtectedScreen({super.key});

  @override
  State<PasswordProtectedScreen> createState() => _PasswordProtectedScreenState();
}

class _PasswordProtectedScreenState extends State<PasswordProtectedScreen> {
  final String password = '1234';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwortgeschützt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bitte geben Sie das Passwort ein:'),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Passwort',
              ),
              onSubmitted: (value) {
                if (value == password) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const StatsAndSettingsScreen()),);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}