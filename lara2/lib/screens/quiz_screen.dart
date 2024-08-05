import 'dart:async';
import 'setup.dart' as setup;
import 'package:flutter/material.dart';
import 'finish_screen.dart';

class QuizScreen extends StatefulWidget {
  final int index;
  const QuizScreen(this.index, {super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final int index;
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];

  List<String> picturesToLearn = [];
  int currentImageIndex = 0;
  bool didNoMistake = true;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    picturesToLearn = getImageList(index);
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

  void update(){
    _controllers = List.generate(currentWord().length, (index) => TextEditingController());
    _focusNodes = List.generate(currentWord().length, (index) => FocusNode());
    didNoMistake = true;
    _focusNodes[0].requestFocus();
  }

  void updateImage() {
    if (didNoMistake) {
      setState(() {
        picturesToLearn.removeAt(currentImageIndex);
        if (picturesToLearn.isEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FinishScreen(index),
            ),
          );
        }
        currentImageIndex = (currentImageIndex % picturesToLearn.length).toInt();
      });
    } else {
      setState(() {
        currentImageIndex = ((currentImageIndex + 1) % picturesToLearn.length).toInt();
      });
    }
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
    return setup.images[getCategory(index)]!;    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(      
      onTap: () {
        if (!_focusNodes[index].hasFocus) {
          _focusNodes[index].requestFocus();
        }
      },
      child: Scaffold(
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
                            decoration: const InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _controllers[index].text = value.toUpperCase();
                          
                              // Test if the user input is correct
                              if (char.toLowerCase() != value.toLowerCase()) {
                                _controllers[index].text = "";
                                didNoMistake = false;
                              } else if(index == currentWord().length - 1) {
                                _focusNodes[index].unfocus();
                                Timer(const Duration(seconds: 4), () {
                                  updateImage();
                                });
                              } else {
                                _focusNodes[index].unfocus();
                                _focusNodes[index + 1].requestFocus();
                              }
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
