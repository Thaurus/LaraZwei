import 'dart:async';
import 'package:lara2/chapter_progress_bar.dart';
import 'package:lara2/shake_animator.dart';

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
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  List<TextEditingController> _controllers = [];
  List<Color> _borderColors = [];
  List<FocusNode> _focusNodes = [];

  List<String> picturesToLearn = [];
  int currentImageIndex = 0;
  bool didNoMistake = true;
  final AudioPlayer audioPlayer = AudioPlayer();
  int errors = 0;
  int hints = 0;
  bool isPlaying = false;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    picturesToLearn = getImageList(widget.index);
    if (widget.developerMode) {
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

  Future<void> playSound() async {
    if(isPlaying) return;
    setState(() {
      isPlaying = true;
    });
    await audioPlayer.play('assets/sounds/error.mp3');
    setState(() {
      isPlaying = false;
    });
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
        globals.chapterMistakesAndHint[setup.getChapterTitle(widget.index)] = {"errors": errors, "hints": hints};
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishScreen(widget.index),
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
    return setup.getChapterTitle(index);
  }

  List<String> getImageList(int index) {
    if (!(index >= 0 && index < setup.images.length)) {
      return [];
    }
    return List.from(setup.images.values.toList()[index]);
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
          title: Text(setup.getChapterTitle(widget.index)),
          centerTitle: true,
          bottom: ChapterProgressBar(
            value: 1 - picturesToLearn.length / getImageList(widget.index).length,
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.5,
                      child: Image.asset(
                        "assets/images/${getCategory(widget.index)}/${currentWord()}.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShakeAnimator(
                          controller: animationController,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            for (int index = 0; index < currentWord().length; index++)
                              Container(
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
                                  border: const OutlineInputBorder(),
                                ),
                                onChanged: (value) async {
                                  _controllers[index].text = value.toUpperCase();
                    
                                  // Test if the user input is correct
                                  if (currentWord()[index].toLowerCase() != value.toLowerCase()) {
                                  _borderColors[index] = Colors.red;
                                  if (globals.playSound) playSound();
                                  _controllers[index].text = "";
                                  didNoMistake = false;
                                  animationController.forward(from: 0.0);
                                  if (globals.playSound) playSound();

                                  } else if (index == currentWord().length - 1) {
                                  _borderColors[index] = Colors.green;
                                  _focusNodes[index].unfocus();
                                  if (widget.developerMode) {
                                    updateImage();
                                  }
                                  Timer(Duration(milliseconds: (globals.secondsToWait * 1000).round()), () {
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
                              ),
                            ],
                          ),
                        ),
                        if (globals.allowHints)
                        IconButton(onPressed: (){
                          int nextEmptyFieldIndex = _controllers.indexWhere((element) => element.text.isEmpty);
                          if(nextEmptyFieldIndex == -1) return;
                          hints++;
                          String nextChar = currentWord()[nextEmptyFieldIndex];
                          print(nextChar);
                          setState(() {
                            _controllers[nextEmptyFieldIndex].text = nextChar.toUpperCase();
                            _borderColors[nextEmptyFieldIndex] = Colors.yellow;
                            _focusNodes[nextEmptyFieldIndex].unfocus();
                            
                            if(nextEmptyFieldIndex >= currentWord().length - 1){
                              if (widget.developerMode) {
                                updateImage();
                              }
                              Timer(Duration(milliseconds: (globals.secondsToWait * 1000).round()), () {
                                updateImage();
                              });
                            }
                            else {
                              _focusNodes[nextEmptyFieldIndex + 1].requestFocus();
                            }
                          });
                        }
                        , icon: const Icon(Icons.lightbulb, color: Colors.amber)),
                      ],
                    ),

                    
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
