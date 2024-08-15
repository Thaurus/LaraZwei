import 'dart:async';
import 'package:lara2/shake_animator.dart';

import 'setup.dart' as setup;
import 'package:flutter/material.dart';
import 'finish_screen.dart';
import 'package:audioplayers/audioplayers.dart';

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
    if (didNoMistake) {
      picturesToLearn.removeAt(currentImageIndex);
      if (picturesToLearn.isEmpty) {
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
        if (!_focusNodes[widget.index].hasFocus) {
          _focusNodes[widget.index].requestFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(setup.getChapterName(widget.index)),
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
                    "assets/images/${getCategory(widget.index)}/${currentWord()}.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: ShakeAnimator(
                    controller: animationController,
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
                                border: const OutlineInputBorder(),
                              ),
                              onChanged: (value) async {
                                _controllers[index].text = value.toUpperCase();
                            
                                // Test if the user input is correct
                                if (char.toLowerCase() != value.toLowerCase()) {
                                  _borderColors[index] = Colors.red;
                                  _controllers[index].text = "";
                                  didNoMistake = false;
                                  animationController.forward(from: 0.0);
                                  playSound();
                                } else if(index == currentWord().length - 1) {
                                  _borderColors[index] = Colors.green;
                                  _focusNodes[index].unfocus();
                                  if(widget.developerMode){
                                    updateImage();
                                  }
                                  Timer(const Duration(seconds: 4), () {
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
