import 'package:flutter/material.dart';

String getChapterTitle(int index) {
  return images.keys.toList()[index]["title"];
}
String getChapterSubtitle(int index) {
  return images.keys.toList()[index]["subtitle"];
}
Color getChapterColor(int index) {
  return images.keys.toList()[index]["color"];
}


Map<Map<String, dynamic>, List<String>> images = {
  {"title": "Kapitel 1", "subtitle": "Einfacher Start", "color": Color(0xFFFF7F50)}: ["Oma", "Opa", "Wal", "Ufo", "Hut", "Hose", "Hase", "Nase"],
  {"title": "Kapitel 2", "subtitle": "Jetzt wird's knifflig", "color": Color(0xFF40E0D0)}: [
    "Sofa",
    "Brot",
    "Lego",
    "Kamel",
    "Palme",
    "Blume",
    "Wolke",
    "Pirat"
  ],
  {"title": "Kapitel 3", "subtitle": "Wörter mit Sch", "color": Color(0xFF4169E1)}: [
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
{"title": "Kapitel 4", "subtitle": "Wörter mit Au", "color": Color(0xFFDAA520)}: [
    "Auto",
    "Auge",
    "Baum",
    "Raupe",
    "Frau",
    "Schaum",
    "Maus",
    "Zaun"
  ],
{"title": "Kapitel 5", "subtitle": "Wörter mit Ei", "color": Color(0xFFFF69B4)}: [
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
  {"title": "Kapitel 6", "subtitle": "Wörter mit Ch", "color": Color(0xFF32CD32)}: ["Acht", "Buch", "Chef", "Dach", "Drache", "Milch", "Nacht"],
  {"title": "Kapitel 7", "subtitle": "Wörter mit Ng", "color": Color(0xFF00BFFF)}: ["Junge", "Junge", "Schlange", "Zange", "Zunge"],
{"title": "Kapitel 8", "subtitle": "Wörter mit Eu", "color": Color(0xFFFF6347)}: ["Eule", "Neun", "Euro", "Kreuz", "Feuer"],
{"title": "Kapitel 9", "subtitle": "Wörter mit nk", "color": Color(0xFF800080)}: ["Bank", "Anker", "Schrank", "Geschenk"],
{"title": "Kapitel 10", "subtitle": "Wörter mit st", "color": Color(0xFF2E8B57)}: ["Stein", "Stift", "Stelzen", "Stempel", "Stern"]
};
