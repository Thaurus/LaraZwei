import '../setup/setup.dart' as setup;
// Settings
bool playSound = true;
double secondsToWait = 0;
bool allowHints = true;
bool easyMode = false;
bool developerMode = false;


bool getChapterAlreadyFinished(int index) {
  bool finished = false;
  for (var chapter in chapterMistakesAndHint.entries) {
    finished = setup.getChapterTitle(index) == chapter.key;
    if (finished) {return true;}
  }

  return false;
}
// Statistics
Map<String, Map<String, int>> chapterMistakesAndHint = {};

