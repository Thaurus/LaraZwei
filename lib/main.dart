import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  final List<TextEditingController> _controllers =
      List.generate(10, (index) => TextEditingController());

  int score = 0;
  int highScore = 0;
  var simpleImages = [
    ["assets/images/simple/affe.png", "affe"],
    ["assets/images/simple/hund.png", "hund"],
    ["assets/images/simple/lila.png", "lila"],
    ["assets/images/simple/oma.png", "oma"]
  ];
  var mediumImages = [
    ["assets/images/medium/fisch.png", "fisch"],
    ["assets/images/medium/katze.png", "katze"],
    ["assets/images/medium/vogel.png", "vogel"]
  ];
  var hardImages = [
    ["assets/images/hard/fuchs.png", "fuchs"],
    ["assets/images/hard/panda.png", "panda"]
  ];
  int picturesCounter = 1;
  var picturesTexts = [];
  int scoreToMedium = 5;
  int scoreToHard = 10;
  var difficultiesNames = ["leicht", "mittel", "schwer"];

  int currentDifficulty = 0;
  int currentImageIndex = 0;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    picturesTexts.add(simpleImages);
    picturesTexts.add(mediumImages);
    picturesTexts.add(hardImages);
    simpleImages.shuffle();
    mediumImages.shuffle();
    hardImages.shuffle();
  }

  void updateImage() {
    //reset difficulty
    if (score == 1 && currentDifficulty > 0) {
      currentDifficulty = 0;
    }
    if (picturesCounter >= picturesTexts[currentDifficulty].length) {
      picturesCounter = 1; //reset counter
      picturesTexts[currentDifficulty].shuffle();
    }
    setState(() {
      currentImageIndex =
          ((currentImageIndex + 1) % picturesTexts[currentDifficulty].length)
              .toInt();
      picturesCounter++;
    });
  }

  String joinTexts(List<TextEditingController> controllers) {
    String text = "";
    for (TextEditingController controller in controllers) {
      text += controller.text;
    }
    return text;
  }

  void clearText(List<TextEditingController> controllers) {
    for (TextEditingController controller in controllers) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Oberhalb: Bild
              Expanded(
                child: Image.asset(
                    picturesTexts[currentDifficulty][currentImageIndex][0],
                    fit: BoxFit.contain),
              ),
              // Unten: Text-Input
              Text("Highscore: $highScore",
                  style: const TextStyle(fontSize: 20.0)),
              Text('Punktestand: $score',
                  style: const TextStyle(fontSize: 20.0)),
              Text(
                  'Aktueller Schwierigkeitsgrad: ${difficultiesNames[currentDifficulty]}',
                  style: const TextStyle(fontSize: 20.0)),

              Expanded(
                  //height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: picturesTexts[currentDifficulty]
                              [currentImageIndex][1]
                          .length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 50, // Adjust the width of each cell as needed
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _controllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _controllers[index].text = value.toUpperCase();
                              String text = joinTexts(_controllers);
                              if (picturesTexts[currentDifficulty]
                                          [currentImageIndex][1]
                                      .substring(
                                          0, text.toLowerCase().length) !=
                                  text.toLowerCase()) {
                                //ist das der richtige Buchstabe?
                                if (score > highScore) {
                                  highScore = score;
                                }
                                setState(() {
                                  score = 0;
                                });
                                _controllers[index].text = "";
                              }

                              if (text.toLowerCase() ==
                                  picturesTexts[currentDifficulty]
                                      [currentImageIndex][1]) {
                                //Bild richtig erraten
                                score++;
                                if (score >= scoreToMedium) {
                                  currentDifficulty =1;
                                  if (score >= scoreToHard){
                                    currentDifficulty = 2;
                                  }
                                  picturesCounter = 1;//reset picture counter
                                }
                                if (score > highScore) {
                                  highScore = score;
                                }
                                clearText(_controllers);
                                updateImage();
                                FocusScope.of(context).nextFocus();
                                FocusScope.of(context).nextFocus();
                              }
                              if (value.isNotEmpty) {
                                if (_controllers[index].text.isNotEmpty) {
                                  // Move to the next cell
                                  FocusScope.of(context).nextFocus();
                                }
                              }
                            },
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
