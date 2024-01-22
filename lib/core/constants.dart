import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
const kPrimaryColor = Color.fromARGB(255, 56, 115, 59);
const kAppBarTextStyle =  TextStyle(
    fontFamily: 'quran',
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color:Colors.white,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 2.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ]);
int bookmarkedAyah = 1;
int bookmarkedSura = 1;
bool fabIsClicked = true;

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

String arabicFont = 'quran';
double arabicFontSize = 28;
double mushafFontSize = 40;

Uri quranAppurl = Uri.parse('https://github.com/itsherifahmed');

Future saveSettings() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('arabicFontSize', arabicFontSize.toInt());
  await prefs.setInt('mushafFontSize', mushafFontSize.toInt());
}

Future getSettings() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    arabicFontSize = await prefs.getInt('arabicFontSize')!.toDouble();
    mushafFontSize = await prefs.getInt('mushafFontSize')!.toDouble();
  } catch (_) {
    arabicFontSize = 28;
    mushafFontSize = 40;
  }
}

saveBookMark(surah, ayah) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt("surah", surah);
  await prefs.setInt("ayah", ayah);
}

readBookmark() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    bookmarkedAyah = prefs.getInt('ayah')!;
    bookmarkedSura = prefs.getInt('surah')!;
    return true;
  } catch (e) {
    return false;
  }
}

List<Map> quran_data = [
  {"surah": "1", "name": "الفاتحة", "type": "Meccan", "juz": "1"},
  {"surah": "2", "name": "البقرة", "type": "Medinan", "juz": "1-2-3"},
  {"surah": "3", "name": "آل عمران", "type": "Medinan", "juz": "3-4"},
  {"surah": "4", "name": "النساء", "type": "Medinan", "juz": "4-5-6"},
  {"surah": "5", "name": "المائدة", "type": "Medinan", "juz": "6"},
  {"surah": "6", "name": "الأنعام", "type": "Meccan", "juz": "7-8"},
  {"surah": "7", "name": "الأعراف", "type": "Meccan", "juz": "8-9"},
  {"surah": "8", "name": "الأنفال", "type": "Medinan", "juz": "9-10"},
  {"surah": "9", "name": "التوبة", "type": "Medinan", "juz": "10-11"},
  {"surah": "10", "name": "يونس", "type": "Meccan", "juz": "11"},
  {"surah": "11", "name": "هود", "type": "Meccan", "juz": "11-12"},
  {"surah": "12", "name": "يوسف", "type": "Meccan", "juz": "12-13"},
  {"surah": "13", "name": "الرعد", "type": "Medinan", "juz": "13"},
  {"surah": "14", "name": "ابراهيم", "type": "Meccan", "juz": "13"},
  {"surah": "15", "name": "الحجر", "type": "Meccan", "juz": "14"},
  {"surah": "16", "name": "النحل", "type": "Meccan", "juz": "14"},
  {"surah": "17", "name": "الإسراء", "type": "Meccan", "juz": "15"},
  {"surah": "18", "name": "الكهف", "type": "Meccan", "juz": "15-16"},
  {"surah": "19", "name": "مريم", "type": "Meccan", "juz": "16"},
  {"surah": "20", "name": "طه", "type": "Meccan", "juz": "16"},
  {"surah": "21", "name": "الأنبياء", "type": "Meccan", "juz": "17"},
  {"surah": "22", "name": "الحج", "type": "Medinan", "juz": "17"},
  {"surah": "23", "name": "المؤمنون", "type": "Meccan", "juz": "18"},
  {"surah": "24", "name": "النور", "type": "Medinan", "juz": "18"},
  {"surah": "25", "name": "الفرقان", "type": "Meccan", "juz": "18-19"},
  {"surah": "26", "name": "الشعراء", "type": "Meccan", "juz": "19"},
  {"surah": "27", "name": "النمل", "type": "Meccan", "juz": "19-20"},
  {"surah": "28", "name": "القصص", "type": "Meccan", "juz": "20"},
  {"surah": "29", "name": "العنكبوت", "type": "Meccan", "juz": "20-21"},
  {"surah": "30", "name": "الروم", "type": "Meccan", "juz": "21"},
  {"surah": "31", "name": "لقمان", "type": "Meccan", "juz": "21"},
  {"surah": "32", "name": "السجدة", "type": "Meccan", "juz": "21"},
  {"surah": "33", "name": "الأحزاب", "type": "Medinan", "juz": "21-22"},
  {"surah": "34", "name": "سبإ", "type": "Meccan", "juz": "22"},
  {"surah": "35", "name": "فاطر", "type": "Meccan", "juz": "22"},
  {"surah": "36", "name": "يس", "type": "Meccan", "juz": "22-23"},
  {"surah": "37", "name": "الصافات", "type": "Meccan", "juz": "23"},
  {"surah": "38", "name": "ص", "type": "Meccan", "juz": "23"},
  {"surah": "39", "name": "الزمر", "type": "Meccan", "juz": "23-24"},
  {"surah": "40", "name": "غافر", "type": "Meccan", "juz": "24"},
  {"surah": "41", "name": "فصلت", "type": "Meccan", "juz": "24-25"},
  {"surah": "42", "name": "الشورى", "type": "Meccan", "juz": "25"},
  {"surah": "43", "name": "الزخرف", "type": "Meccan", "juz": "25"},
  {"surah": "44", "name": "الدخان", "type": "Meccan", "juz": "25"},
  {"surah": "45", "name": "الجاثية", "type": "Meccan", "juz": "25"},
  {"surah": "46", "name": "الأحقاف", "type": "Meccan", "juz": "26"},
  {"surah": "47", "name": "محمد", "type": "Medinan", "juz": "26"},
  {"surah": "48", "name": "الفتح", "type": "Medinan", "juz": "26"},
  {"surah": "49", "name": "الحجرات", "type": "Medinan", "juz": "26"},
  {"surah": "50", "name": "ق", "type": "Meccan", "juz": "26"},
  {"surah": "51", "name": "الذاريات", "type": "Meccan", "juz": "26-27"},
  {"surah": "52", "name": "الطور", "type": "Meccan", "juz": "27"},
  {"surah": "53", "name": "النجم", "type": "Meccan", "juz": "27"},
  {"surah": "54", "name": "القمر", "type": "Meccan", "juz": "27"},
  {"surah": "55", "name": "الرحمن", "type": "Medinan", "juz": "27"},
  {"surah": "56", "name": "الواقعة", "type": "Meccan", "juz": "27"},
  {"surah": "57", "name": "الحديد", "type": "Medinan", "juz": "27"},
  {"surah": "58", "name": "المجادلة", "type": "Medinan", "juz": "28"},
  {"surah": "59", "name": "الحشر", "type": "Medinan", "juz": "28"},
  {"surah": "60", "name": "الممتحنة", "type": "Medinan", "juz": "28"},
  {"surah": "61", "name": "الصف", "type": "Medinan", "juz": "28"},
  {"surah": "62", "name": "الجمعة", "type": "Medinan", "juz": "28"},
  {"surah": "63", "name": "المنافقون", "type": "Medinan", "juz": "28"},
  {"surah": "64", "name": "التغابن", "type": "Medinan", "juz": "28"},
  {"surah": "65", "name": "الطلاق", "type": "Medinan", "juz": "28"},
  {"surah": "66", "name": "التحريم", "type": "Medinan", "juz": "28"},
  {"surah": "67", "name": "الملك", "type": "Meccan", "juz": "29"},
  {"surah": "68", "name": "القلم", "type": "Meccan", "juz": "29"},
  {"surah": "69", "name": "الحاقة", "type": "Meccan", "juz": "29"},
  {"surah": "70", "name": "المعارج", "type": "Meccan", "juz": "29"},
  {"surah": "71", "name": "نوح", "type": "Meccan", "juz": "29"},
  {"surah": "72", "name": "الجن", "type": "Meccan", "juz": "29"},
  {"surah": "73", "name": "المزمل", "type": "Meccan", "juz": "29"},
  {"surah": "74", "name": "المدثر", "type": "Meccan", "juz": "29"},
  {"surah": "75", "name": "القيامة", "type": "Meccan", "juz": "29"},
  {"surah": "76", "name": "الانسان", "type": "Medinan", "juz": "29"},
  {"surah": "77", "name": "المرسلات", "type": "Meccan", "juz": "29"},
  {"surah": "78", "name": "النبإ", "type": "Meccan", "juz": "30"},
  {"surah": "79", "name": "النازعات", "type": "Meccan", "juz": "30"},
  {"surah": "80", "name": "عبس", "type": "Meccan", "juz": "30"},
  {"surah": "81", "name": "التكوير", "type": "Meccan", "juz": "30"},
  {"surah": "82", "name": "الإنفطار", "type": "Meccan", "juz": "30"},
  {"surah": "83", "name": "المطففين", "type": "Meccan", "juz": "30"},
  {"surah": "84", "name": "الإنشقاق", "type": "Meccan", "juz": "30"},
  {"surah": "85", "name": "البروج", "type": "Meccan", "juz": "30"},
  {"surah": "86", "name": "الطارق", "type": "Meccan", "juz": "30"},
  {"surah": "87", "name": "الأعلى", "type": "Meccan", "juz": "30"},
  {"surah": "88", "name": "الغاشية", "type": "Meccan", "juz": "30"},
  {"surah": "89", "name": "الفجر", "type": "Meccan", "juz": "30"},
  {"surah": "90", "name": "البلد", "type": "Meccan", "juz": "30"},
  {"surah": "91", "name": "الشمس", "type": "Meccan", "juz": "30"},
  {"surah": "92", "name": "الليل", "type": "Meccan", "juz": "30"},
  {"surah": "93", "name": "الضحى", "type": "Meccan", "juz": "30"},
  {"surah": "94", "name": "الشرح", "type": "Meccan", "juz": "30"},
  {"surah": "95", "name": "التين", "type": "Meccan", "juz": "30"},
  {"surah": "96", "name": "العلق", "type": "Meccan", "juz": "30"},
  {"surah": "97", "name": "القدر", "type": "Meccan", "juz": "30"},
  {"surah": "98", "name": "البينة", "type": "Medinan", "juz": "30"},
  {"surah": "99", "name": "الزلزلة", "type": "Medinan", "juz": "30"},
  {"surah": "100", "name": "العاديات", "type": "Meccan", "juz": "30"},
  {"surah": "101", "name": "القارعة", "type": "Meccan", "juz": "30"},
  {"surah": "102", "name": "التكاثر", "type": "Meccan", "juz": "30"},
  {"surah": "103", "name": "العصر", "type": "Meccan", "juz": "30"},
  {"surah": "104", "name": "الهمزة", "type": "Meccan", "juz": "30"},
  {"surah": "105", "name": "الفيل", "type": "Meccan", "juz": "30"},
  {"surah": "106", "name": "قريش", "type": "Meccan", "juz": "30"},
  {"surah": "107", "name": "الماعون", "type": "Meccan", "juz": "30"},
  {"surah": "108", "name": "الكوثر", "type": "Meccan", "juz": "30"},
  {"surah": "109", "name": "الكافرون", "type": "Meccan", "juz": "30"},
  {"surah": "110", "name": "النصر", "type": "Medinan", "juz": "30"},
  {"surah": "111", "name": "المسد", "type": "Meccan", "juz": "30"},
  {"surah": "112", "name": "الإخلاص", "type": "Meccan", "juz": "30"},
  {"surah": "113", "name": "الفلق", "type": "Meccan", "juz": "30"},
  {"surah": "114", "name": "الناس", "type": "Meccan", "juz": "30"}
];

List<int> noOfVerses = [
  7,
  286,
  200,
  176,
  120,
  165,
  206,
  75,
  129,
  109,
  123,
  111,
  43,
  52,
  99,
  128,
  111,
  110,
  98,
  135,
  112,
  78,
  118,
  64,
  77,
  227,
  93,
  88,
  69,
  60,
  34,
  30,
  73,
  54,
  45,
  83,
  182,
  88,
  75,
  85,
  54,
  53,
  89,
  59,
  37,
  35,
  38,
  29,
  18,
  45,
  60,
  49,
  62,
  55,
  78,
  96,
  29,
  22,
  24,
  13,
  14,
  11,
  11,
  18,
  12,
  12,
  30,
  52,
  52,
  44,
  28,
  28,
  20,
  56,
  40,
  31,
  50,
  40,
  46,
  42,
  29,
  19,
  36,
  25,
  22,
  17,
  19,
  26,
  30,
  20,
  15,
  21,
  11,
  8,
  8,
  19,
  5,
  8,
  8,
  11,
  11,
  8,
  3,
  9,
  5,
  4,
  7,
  3,
  6,
  3,
  5,
  4,
  5,
  6
];

List<dynamic> arabic = [];
List malayalam = [];
List quran = [];

Future readJson() async {
  final String response =
      await rootBundle.loadString("assets/hafs_smart_v8.json");
  final data = json.decode(response);
  arabic = data["quran"];

  quran = [arabic];
  //print(quran[0][40]['sura_no']);
  return quran = [arabic];
}
