String getChapterName(int index) {
  String unformatted = images.keys.toList()[index];
  return unformatted[0].toUpperCase() + unformatted.substring(1);
}

Map<String, List<String>> images = {
  /*"einfach": [
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
  "mittel": [
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
  "schwer": [
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
  ],*/
  "Kapitel 1": ["Oma", "Opa", "Wal", "Ufo", "Hut", "Hose", "Hase", "Nase"],
  "Kapitel 2": [
    "Sofa",
    "Brot",
    "Lego",
    "Kamel",
    "Palme",
    "Blume",
    "Wolke",
    "Pirat"
  ],
  "Kapitel 3 Sch": [
    "Schaf",
    "Schal",
    "Schere",
    "Schwan",
    "Fisch",
    "Tisch",
    "Tasche",
    "Dusche",
    "Frosch",
    "Flasche"
  ],
  "Kapitel 4 Au": [
    "Auto",
    "Auge",
    "Baum",
    "Raupe",
    "Frau",
    "Schaum",
    "Maus",
    "Zaun"
  ],
  "Kapitel 5 Ei": [
    "Ei",
    "Eis",
    "Eimer",
    "Bein",
    "Drei",
    "Leiter",
    "Zwei",
    "Schwein",
    "Schleife",
    "Leine"
  ],
  "Kapitel 8 Eu": ["Eule", "Neun", "Euro", "Kreuz", "Feuer"],
  "Kapitel 9 nk": ["Bank", "Anker", "Schrank", "Geschenk"],
  "Kapitel 10 st": ["Stein", "Stift", "Stelzen", "Stempel", "Stern"]
};
