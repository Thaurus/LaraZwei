import 'package:flutter/material.dart';
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
      body: Stack(
        children: [
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                padding: EdgeInsets.symmetric(
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
                                        QuizScreen(index, developerMode),
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

                                  SizedBox(height: 5),
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
