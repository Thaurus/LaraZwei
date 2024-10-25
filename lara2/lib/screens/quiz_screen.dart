import 'dart:async';
import 'package:lara2/widgets/chapter_progress_bar.dart';
import 'package:lara2/widgets/shake_animator.dart';

import '../setup/setup.dart' as setup;
import 'package:flutter/material.dart';
import 'finish_screen.dart';
import 'package:lara2/setup/globals.dart' as globals;

import 'package:flutter_tts/flutter_tts.dart';

class QuizScreen extends StatefulWidget {
  final int index;
  const QuizScreen(this.index, {super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  // For text word field
  List<TextEditingController> _controllers = [];
  List<Color> _borderColors = [];
  List<FocusNode> _focusNodes = [];
  late AnimationController animationController;
  late AnimationController loadingAnimationController;

  List<String> picturesToLearn = [];
  int currentImageIndex = 0;
  bool didNoMistake = true;
  int errors = 0;
  int hints = 0;
  bool isPlaying = false;

  late FlutterTts flutterTts;
  Timer? focusTimer;

  @override
  void initState() {
    super.initState();
    loadingAnimationController = AnimationController(
      duration: Duration(seconds: globals.secondsToWait.toInt()),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    picturesToLearn = getImageList(widget.index);
    if (globals.developerMode) {
      picturesToLearn = picturesToLearn.sublist(0, 2);
    }
    update();

    flutterTts = FlutterTts();
    flutterTts.setLanguage("de-DE");
    flutterTts.setSpeechRate(0.7);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
    focusTimer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      if (getCurrentCharIndex != -1) {
        _focusNodes[getCurrentCharIndex].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
    animationController.dispose();
  }

  void update() {
    loadingAnimationController.reset();
    _controllers =
        List.generate(currentWord.length, (index) => TextEditingController());
    _focusNodes = List.generate(currentWord.length, (index) => FocusNode());
    _borderColors = List.generate(currentWord.length, (index) => Colors.black);
    didNoMistake = true;
    _focusNodes[0].requestFocus();
  }

  void updateImage() {
    if (globals.easyMode || didNoMistake) {
      if (!didNoMistake) errors++;
      picturesToLearn.removeAt(currentImageIndex);
      if (picturesToLearn.isEmpty) {
        globals.chapterMistakesAndHint[setup.getChapterTitle(widget.index)] = {
          "errors": errors,
          "hints": hints
        };
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishScreen(widget.index),
          ),
        );
        return;
      } else {
        currentImageIndex =
            (currentImageIndex % picturesToLearn.length).toInt();
      }
    } else {
      errors++;
      currentImageIndex =
          ((currentImageIndex + 1) % picturesToLearn.length).toInt();
    }
    setState(() {});
    update();
  }

  String get currentWord => picturesToLearn[currentImageIndex];
  String getCategory(int index) {
    return setup.getChapterTitle(index);
  }

  List<String> getImageList(int index) {
    if (!(index >= 0 && index < setup.images.length)) {
      return [];
    }
    return List.from(setup.images.values.toList()[index]);
  }

  int get getCurrentCharIndex =>
      _controllers.indexWhere((element) => element.text.isEmpty);

  Widget wordTextField() {
    return ShakeAnimator(
      controller: animationController,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int index = 0; index < currentWord.length; index++)
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
                    if (currentWord[index].toLowerCase() !=
                        value.toLowerCase()) {
                      _borderColors[index] = Colors.red;
                      _controllers[index].text = "";
                      didNoMistake = false;
                      animationController.forward(from: 0.0);
                    } else if (index == currentWord.length - 1) {
                      _borderColors[index] = Colors.green;
                      _focusNodes[index].unfocus();
                      if (globals.developerMode) {
                        updateImage();
                      }
                      loadingAnimationController.forward(from: 0.0);
                      Future.delayed(
                          Duration(
                              milliseconds:
                                  (globals.secondsToWait * 1000).round()), () {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int index = getCurrentCharIndex;
        if (index != -1 && !_focusNodes[index].hasFocus) {
          _focusNodes[index].requestFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(setup.getChapterTitle(widget.index)),
          centerTitle: true,
          bottom: ChapterProgressBar(
            value:
                1 - picturesToLearn.length / getImageList(widget.index).length,
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.5,
                      child: Image.asset(
                        "assets/images/${getCategory(widget.index)}/$currentWord.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (globals.playSound)
                          IconButton(
                              onPressed: () {
                                flutterTts.speak(currentWord);
                                int index = getCurrentCharIndex;
                                if (index != -1 &&
                                    !_focusNodes[index].hasFocus) {
                                  _focusNodes[index].requestFocus();
                                }
                              },
                              icon: const Icon(Icons.volume_up)),
                        wordTextField(),
                        if (globals.allowHints)
                          IconButton(
                              onPressed: () {
                                int nextEmptyFieldIndex = getCurrentCharIndex;
                                if (nextEmptyFieldIndex == -1) return;
                                hints++;
                                didNoMistake = false;
                                String nextChar =
                                    currentWord[nextEmptyFieldIndex];
                                setState(() {
                                  _controllers[nextEmptyFieldIndex].text =
                                      nextChar.toUpperCase();
                                  _borderColors[nextEmptyFieldIndex] =
                                      Colors.amber;
                                  _focusNodes[nextEmptyFieldIndex].unfocus();
                                  if (nextEmptyFieldIndex >=
                                      currentWord.length - 1) {
                                    loadingAnimationController.forward(
                                        from: 0.0);
                                    if (globals.developerMode) {
                                      updateImage();
                                    }
                                    Timer(
                                        Duration(
                                            milliseconds:
                                                (globals.secondsToWait * 1000)
                                                    .round()), () {
                                      updateImage();
                                    });
                                  } else {
                                    _focusNodes[nextEmptyFieldIndex + 1]
                                        .requestFocus();
                                  }
                                });
                              },
                              icon: const Icon(Icons.lightbulb,
                                  color: Colors.amber)),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        value: loadingAnimationController.value,
                      ),
                    )
                  ]);
            }),
          ),
        ),
      ),
    );
  }
}
