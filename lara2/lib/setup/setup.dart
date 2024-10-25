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


const String elternText =
    "So funktioniert Lara2:"
    "\n\n"
    "Lara2 ist eine Lern-Software, die Kinder beim Schreiben lernen unterstützen soll. Hier einige Informationen und Tipps, wie Sie die Software optimal nutzen können:"
    "\n\n"
    "1. Lerninhalte"
    "\n"
    "Das Programm zeigt auf dem Bildschirm jeweils einen Gegenstand, eine Person oder ein Tier aus der Lebenswelt der Kinder. Das Kind schreibt das passende Wort unter das jeweilige Bild. Die Kästchen geben dabei die Anzahl der Buchstaben vor. Das Progamm enhält über 100 Begriffe, kapitelweise nach bestimmten Lauten sortiert und mit zunehmendem Schwierigkeitsgrad. Alle Wörter sind lautgetreu."
    "\n\n"
    "2. Feedback"
    "\n"
    "Das Feedback erfolgt unmittelbar, indem Fehlschreibungen nicht übernommen, sondern duch ein visuelles Signal angezeigt werden. So können Fehler erkannt und selbstständig korrigiert werden. Wörter, bei denen ein Fehler gemacht wurde, werden am Ende des Kapitels so oft wiederholt bis das Wort fehlerfrei geschrieben und damit richtig verinnerlicht wurde. Der zunehmende Balken am oberen Bildschirmrand zeigt den Fortschritt des Kapitels an. Das Programm ist bewusst einfach und übersichtlich gehalten, sodass Kinder es schnell selbstständig navigieren können und nicht unnötig abgelenkt werden."
    "\n\n"
    "3. Hilfen"
    "\n"
    "Mit einem Klick auf den Lautsprecher wird das abgebildete Wort vorgsprochen. Kommt ein Kind bei einem Wort nicht weiter, kann es mit einem Klick auf die Glühbirne neben dem Wort den jeweils nächste Buchstaben anzeigen lassen. Das Wort wird dann am Ende des Kapitels so oft wiederholt, bis es ohne Unterstützung geschrieben werden kann."
    "\n\n"
    "4. LehrerInnen-/Eltern-Bereich:"
    "\n"
    "Bevor das jeweils nächste Bild angezeigt wird, wird Zeit gegeben, in der das Wort nachgelesen werden kann. Die Zeit kann zwischen 0 und 4 eingestellt werden. Der Sound kann ein- oder ausgeschaltet werden. Ebenso können die Tipps ein- oder ausgeschaltet werden. Wird der einfache Modus aktiviert, müssen falsch geschriebene Wörter am Ende des Kapitels nicht erneut geschrieben werden."
    "\n\n"
    "5. Gemeinsames Lernen:"
    "\n"
    "Beim gemeinsamen Lernen können Wörter in Silben gegliedert vorgesprochen werden. Beispiel Sofa. „Was hörst du am Anfang?“. „Genau, jetzt steht dort «S» und es fehlt noch «ofa».“„Was hört du als nächstes? Gut, jetzt hast du «So» geschrieben und es fehlt noch «fa»“ usw. Wenn Sie Ihrem Kind einzelne Buchstaben oder Worte vorsprechen, sollten diese lautiert werden, ein d ist also nicht dee sondern «d», g nicht gee, sondern «g», sch ist nicht ess-ce-ha sondern «sch», f ist nicht ef, sondern «f» usw. Achten Sie beim Üben auf eine altersangemessene Bildschirmzeit."
    "\n"
    "\n"
    "Bildnachweis: Icons von Freepik";



























