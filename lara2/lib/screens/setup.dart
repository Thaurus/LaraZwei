String getChapterTitle(int index) {
  return images.keys.toList()[index]["title"];
}
String getChapterSubtitle(int index) {
  return images.keys.toList()[index]["subtitle"];
}
/*String getChapterColor(int index) {
  return images.keys.toList()[index]["title"];
}*/


Map<Map<String, dynamic>, List<String>> images = {
  {"title": "Kapitel 1", "subtitle": "Einfacher Start"}: ["Oma", "Opa", "Wal", "Ufo", "Hut", "Hose", "Hase", "Nase"],
  {"title": "Kapitel 2", "subtitle": "Jetzt wird's knifflig"}: [
    "Sofa",
    "Brot",
    "Lego",
    "Kamel",
    "Palme",
    "Blume",
    "Wolke",
    "Pirat"
  ],
  {"title": "Kapitel 3", "subtitle": "Wörter mit Sch"}: [
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
{"title": "Kapitel 4", "subtitle": "Wörter mit Au"}: [
    "Auto",
    "Auge",
    "Baum",
    "Raupe",
    "Frau",
    "Schaum",
    "Maus",
    "Zaun"
  ],
{"title": "Kapitel 5", "subtitle": "Wörter mit Ei"}: [
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
{"title": "Kapitel 8", "subtitle": "Wörter mit Eu"}: ["Eule", "Neun", "Euro", "Kreuz", "Feuer"],
{"title": "Kapitel 9", "subtitle": "Wörter mit nk"}: ["Bank", "Anker", "Schrank", "Geschenk"],
{"title": "Kapitel 10", "subtitle": "Wörter mit st"}: ["Stein", "Stift", "Stelzen", "Stempel", "Stern"]
};
