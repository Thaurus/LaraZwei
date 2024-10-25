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
  {"title": "Kapitel 1", "subtitle": "Einfacher Start", "color": Color(0xFFFF7F50)}: ["Oma","Opa", "Wal", "Ufo", "Hut", "Hose", "Hase", "Nase"],
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
  {"title": "Kapitel 3", "subtitle": "Wörter mit sch", "color": Color(0xFF4169E1)}: [
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
{"title": "Kapitel 4", "subtitle": "Wörter mit au", "color": Color(0xFF2E8B57)}: [
    "Auto",
    "Auge",
    "Baum",
    "Raupe",
    "Frau",
    "Schaum",
    "Maus",
    "Zaun"
  ],
{"title": "Kapitel 5", "subtitle": "Wörter mit ei", "color": Color(0xFFFF69B4)}: [
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
  {"title": "Kapitel 6", "subtitle": "Wörter mit ch", "color": Color(0xFF32CD32)}: ["Acht", "Buch", "Koch", "Dach", "Drache", "Milch", "Nacht"],
  {"title": "Kapitel 7", "subtitle": "Wörter mit ng", "color": Color(0xFF00BFFF)}: ["Junge", "Junge", "Schlange", "Zange", "Zunge"],
{"title": "Kapitel 8", "subtitle": "Wörter mit eu", "color": Color(0xFFFF6347)}: ["Eule", "Neun", "Euro", "Kreuz", "Feuer"],
{"title": "Kapitel 9", "subtitle": "Wörter mit nk", "color": Color(0xFF800080)}: ["Bank", "Anker", "Schrank", "Geschenk"],
{"title": "Kapitel 10", "subtitle": "Wörter mit st", "color": Color(0xFFDAA520)}: ["Stein", "Stift", "Stelzen", "Stempel", "Stern"],
  {"title": "Kapitel 11", "subtitle": "Wörter mit z", "color": Color(0xFFd15078)}: ["Herz","Kerze", "Pilz", "Salz", "Zaun", "Zebra", "Zelt", "Zitrone"],
  {"title": "Kapitel 12", "subtitle": "Wörter mit r", "color": Color(0xFFffd511)}: ["Birne", "Nashorn", "Stern", "Tor", "Tür", "Herz", "Würfel"],
  {"title": "Kapitel 13", "subtitle": "Wörter mit pf", "color": Color(0xFF3100b6)}: ["Apfel", "Knopf", "Pfeil", "Pferd", "Pflaume", "Topf", "Tropfen"],
  {"title": "Kapitel 14", "subtitle": "Wörter mit er", "color": Color(0xFFb6002d)}: ["Feder", "Fenster", "Finger", "Locher", "Mauer", "Taucher"],
  {"title": "Kapitel 15", "subtitle": "Wörter mit en", "color": Color(0xFFfda103)}: ["Besen", "Daumen", "Knochen", "Kuchen", "Ofen", "Regen"],
  {"title": "Kapitel 16", "subtitle": "Wörter mit el", "color": Color(0xFF9ac357)}: ["Ampel", "Engel", "Gabel", "Igel", "Muschel", "Schaukel", "Tafel"]
};
