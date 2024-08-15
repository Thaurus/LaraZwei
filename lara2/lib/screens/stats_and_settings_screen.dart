import 'package:flutter/material.dart';
import 'package:lara2/globals.dart' as globals;

class StatsAndSettingsScreen extends StatefulWidget {
  final int initTab;
  const StatsAndSettingsScreen({required this.initTab, super.key});

  @override
  State<StatsAndSettingsScreen> createState() => _StatsAndSettingsScreenState();
}

class _StatsAndSettingsScreenState extends State<StatsAndSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initTab,
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
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text("Abgeschlossene Kapitel", style: TextStyle(fontSize: 20),),
                const SizedBox(height: 16.0),
                DataTable(columns: 
                  const [
                    DataColumn(label: Text('Kapitel')),
                    DataColumn(label: Text('Anzahl Fehler')),
                  ],
                  rows: globals.finishedChapters.map((chapter) {
                    return DataRow(cells: [
                      DataCell(Text(chapter)),
                      DataCell(Text(globals.chapterMistakes[chapter].toString())),
                    ]);
                  }).toList(),
                ),
              ],
            ),
          )
        ),
        Center(
          child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text("Einstellungen", style: TextStyle(fontSize: 20),),
                const SizedBox(height: 16.0),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        const TableCell(
                          child: Text('Sound abspielen'),
                        ),
                        TableCell(
                          child: Switch(
                            value: globals.playSound,
                            onChanged: (value) {
                              setState(() {
                                globals.playSound = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Text('Sekunden warten'),
                        ),
                        TableCell(
                          child: Row(
                            children: [
                              Text(globals.secondsToWait.toStringAsFixed(0)),
                              Expanded(
                                child: Slider(
                                  value: globals.secondsToWait,
                                  min: 0,
                                  max: 5.0,
                                  divisions: 5,
                                  label: globals.secondsToWait.toStringAsFixed(0),
                                  onChanged: (value) {
                                    setState(() {
                                      globals.secondsToWait = value;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                  inactiveColor: Colors.blue[100],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Row(
                            children: [
                              const Text('Einfacher Modus'),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Einfacher Modus'),
                                        content: const Text('Im einfachen Modus müssen falsch geschriebene Wörter nicht nochmal geschrieben werden.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        TableCell(
                          child: Switch(
                            value: globals.easyMode,
                            onChanged: (value) {
                              setState(() {
                                globals.easyMode = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
            ),
            ),
        ),
        ],
      ),
      ),
    );
  }
}

class PasswordProtectedScreen extends StatefulWidget {
  final int initTab;
  const PasswordProtectedScreen({this.initTab = 0, super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bitte geben Sie das Passwort ein:'),
              const SizedBox(height: 16.0),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Passwort',
                ),
                onChanged: (value) {
                  if (value == password) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StatsAndSettingsScreen(initTab: widget.initTab)),);
                  }
                },
                onSubmitted: (value) {
                  if (value == password) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StatsAndSettingsScreen(initTab: widget.initTab)),);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}