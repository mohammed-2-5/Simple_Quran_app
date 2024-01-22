class QuranModel {
  QuranModel({
      this.malayalam, 
      this.quran,});

  QuranModel.fromJson(dynamic json) {
    if (json['malayalam'] != null) {
      malayalam = [];
      json['malayalam'].forEach((v) {
        malayalam?.add(Malayalam.fromJson(v));
      });
    }
    if (json['quran'] != null) {
      quran = [];
      json['quran'].forEach((v) {
        quran?.add(Quran.fromJson(v));
      });
    }
  }
  List<Malayalam>? malayalam;
  List<Quran>? quran;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (malayalam != null) {
      map['malayalam'] = malayalam?.map((v) => v.toJson()).toList();
    }
    if (quran != null) {
      map['quran'] = quran?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Quran {
  Quran({
      this.id, 
      this.jozz, 
      this.suraNo, 
      this.suraNameEn, 
      this.suraNameAr, 
      this.page, 
      this.lineStart, 
      this.lineEnd, 
      this.ayaNo, 
      this.ayaText, 
      this.ayaTextEmlaey,});

  Quran.fromJson(dynamic json) {
    id = json['id'];
    jozz = json['jozz'];
    suraNo = json['sura_no'];
    suraNameEn = json['sura_name_en'];
    suraNameAr = json['sura_name_ar'];
    page = json['page'];
    lineStart = json['line_start'];
    lineEnd = json['line_end'];
    ayaNo = json['aya_no'];
    ayaText = json['aya_text'];
    ayaTextEmlaey = json['aya_text_emlaey'];
  }
  num? id;
  num? jozz;
  num? suraNo;
  String? suraNameEn;
  String? suraNameAr;
  num? page;
  num? lineStart;
  num? lineEnd;
  num? ayaNo;
  String? ayaText;
  String? ayaTextEmlaey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['jozz'] = jozz;
    map['sura_no'] = suraNo;
    map['sura_name_en'] = suraNameEn;
    map['sura_name_ar'] = suraNameAr;
    map['page'] = page;
    map['line_start'] = lineStart;
    map['line_end'] = lineEnd;
    map['aya_no'] = ayaNo;
    map['aya_text'] = ayaText;
    map['aya_text_emlaey'] = ayaTextEmlaey;
    return map;
  }

}

class Malayalam {
  Malayalam({
      this.chapter, 
      this.verse, 
      this.text,});

  Malayalam.fromJson(dynamic json) {
    chapter = json['chapter'];
    verse = json['verse'];
    text = json['text'];
  }
  num? chapter;
  num? verse;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chapter'] = chapter;
    map['verse'] = verse;
    map['text'] = text;
    return map;
  }

}