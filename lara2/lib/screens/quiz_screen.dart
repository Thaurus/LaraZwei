import 'dart:async';
import 'setup.dart' as setup;
import 'package:flutter/material.dart';
import 'finish_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lara2/globals.dart' as globals;

class QuizScreen extends StatefulWidget {
  final int index;
  final bool developerMode;
  const QuizScreen(this.index, this.developerMode, {super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState(this.index, this.developerMode);
}

class _QuizScreenState extends State<QuizScreen> {
  late final int index;
  late final bool developerMode;
  _QuizScreenState(this.index, this.developerMode);

  List<TextEditingController> _controllers = [];
  List<Color> _borderColors = [];
  List<FocusNode> _focusNodes = [];

  List<String> picturesToLearn = [];
  int currentImageIndex = 0;
  bool didNoMistake = true;
  final AudioPlayer audioPlayer = AudioPlayer();
  int errors = 0;


  @override
  void initState() {
    super.initState();
    picturesToLearn = getImageList(index);
    if (developerMode) {
      picturesToLearn = picturesToLearn.sublist(0,2);
    }
    update();
  }

  @override
  void dispose(){
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void playSound() async {
    if (audioPlayer.state != PlayerState.PLAYING) {
      await audioPlayer.play('assets/sounds/error.mp3');
    } else {
      await audioPlayer.stop();
      await audioPlayer.play('assets/sounds/error.mp3');
    }
  }

  void update(){
    _controllers = List.generate(currentWord().length, (index) => TextEditingController());
    _focusNodes = List.generate(currentWord().length, (index) => FocusNode());
    _borderColors = List.generate(currentWord().length, (index) => Colors.black);
    didNoMistake = true;
    _focusNodes[0].requestFocus();
  }

  void updateImage() {
    if (globals.easyMode || didNoMistake) {
      if (!didNoMistake) errors++;
      picturesToLearn.removeAt(currentImageIndex);
      if (picturesToLearn.isEmpty) {
        globals.chapterMistakes[setup.getChapterName(index)] = errors;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishScreen(index),
          ),  
        );
        return;
      } else {
        currentImageIndex = (currentImageIndex % picturesToLearn.length).toInt();
      }
    } else {
        errors++;  
        currentImageIndex = ((currentImageIndex + 1) % picturesToLearn.length).toInt();
    }
    setState(() {});
    update();
  }


  String currentWord() => picturesToLearn[currentImageIndex];
  String getCategory(int index) {
    return setup.images.keys.toList()[index];
  }

  List<String> getImageList(int index) {
    if (!(index >= 0 && index < setup.images.length)) {
      return [];
    }
    return List.from(setup.images[getCategory(index)]!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(      
      onTap: () {
        int index = _controllers.indexWhere((element) => element.text.isEmpty);
        if (index != -1 && !_focusNodes[index].hasFocus) {
          _focusNodes[index].requestFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(setup.getChapterName(index)),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/images/${getCategory(index)}/${currentWord()}.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: currentWord().length,
                    itemBuilder: (context, index) {
                      String char = currentWord()[index];
                      return Container(
                        width: 50,
                        margin: const EdgeInsets.all(5),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _controllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodes[index],
                            decoration: InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _borderColors[index]),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _borderColors[index]),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _controllers[index].text = value.toUpperCase();
                          
                              // Test if the user input is correct
                              if (char.toLowerCase() != value.toLowerCase()) {
                                _borderColors[index] = Colors.red;
                                if(globals.playSound) playSound();
                                _controllers[index].text = "";
                                didNoMistake = false;
                                
                              } else if(index == currentWord().length - 1) {
                                _borderColors[index] = Colors.green;
                                _focusNodes[index].unfocus();
                                if(developerMode){
                                  updateImage();
                                }
                                Timer(Duration(milliseconds: (globals.secondsToWait*1000).round()), () {
                                  updateImage();
                                });
                              } else {
                                _borderColors[index] = Colors.green;
                                _focusNodes[index].unfocus();
                                _focusNodes[index + 1].requestFocus();
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
