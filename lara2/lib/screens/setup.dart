
String getChapterName(int index) {
  String unformatted = images.keys.toList()[index];
  return unformatted[0].toUpperCase() + unformatted.substring(1);
}

Map<String, List<String>> images = {
  "simple": [
    "affe",
    "hund",
    "lila",
    "oma",
    "haus",
    "buch",
    "baum",
    "hand",
    "ei",
    "hase",
    "maus",
    "auto",
    "ball",
    "apfel"
  ],
  "medium": [
    "fisch",
    "katze",
    "vogel",
    "tasse",
    "flasche",
    "stuhl",
    "schuh",
    "blume",
    "keks",
    "wurm",
    "stern",
    "stein",
    "brot"
  ],
  "hard": [
    "fuchs",
    "panda",
    "kerze",
    "kamera",
    "schiff",
    "lampe",
    "schwamm",
    "gitarre",
    "kuchen",
    "trampolin",
    "fahrrad",
    "ballon",
    "hamster"
  ]
};
