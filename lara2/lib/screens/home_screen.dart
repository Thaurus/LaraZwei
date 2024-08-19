import 'package:flutter/material.dart';
import 'package:lara2/screens/stats_and_settings_screen.dart';
import 'quiz_screen.dart';
import '../setup/setup.dart' as setup;
import '../setup/globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordProtectedScreen(initTab: 0)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordProtectedScreen(initTab: 1)));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            // Number of columns
                            crossAxisSpacing: 16.0,
                            // Horizontal space between buttons
                            mainAxisSpacing: 16.0,
                            // Vertical space between buttons
                            childAspectRatio:
                                2 / 1, // Width/Height ratio of buttons
                          ),
                          itemCount: setup.images.length,
                          itemBuilder: (context, index) {
                            return LayoutBuilder(
                            builder: (context, constraints) {
                            double fontSizeTitle = constraints.maxHeight * 0.2;
                            double fontSizeSubtitle = constraints.maxHeight * 0.1;
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.blue[200 + index * 100],
                                elevation: 2.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QuizScreen(index),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    setup.getChapterTitle(index),
                                    style: TextStyle(
                                        fontSize: fontSizeTitle,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                      overflow: TextOverflow.ellipsis
                                  ),

                                  const SizedBox(height: 5),
                                  Text(
                                    setup.getChapterSubtitle(index),
                                    style: TextStyle(
                                        fontSize: fontSizeSubtitle, color: Colors.white),
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ],
                              ),
                            );
                          }
                          );
                          }
                          )
                  )
                ]),
          ),
          Positioned(
            //Developer button
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              backgroundColor: globals.developerMode ? Colors.red : Colors.grey,
              onPressed: () {
                setState(() {
                  globals.developerMode = !globals.developerMode;  
                });
              },
              mini: true, // Makes the button small
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
