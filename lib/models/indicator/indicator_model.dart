// To parse this JSON data, do
//
//     final indicator = indicatorFromJson(jsonString);

import 'dart:convert';

Indicator indicatorFromJson(String str) => Indicator.fromJson(json.decode(str));

String indicatorToJson(Indicator data) => json.encode(data.toJson());

class Indicator {
  Indicator({
    required this.data,
  });

  List<IndicatorItem> data;

  factory Indicator.fromJson(Map<String, dynamic> json) => Indicator(
        data: List<IndicatorItem>.from(
            json["data"].map((x) => IndicatorItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class IndicatorItem {
  IndicatorItem({
    required this.user,
    required this.cahaya,
    required this.kelembapanTanah,
    required this.kelembapanUdara,
    required this.suhuUdara,
    required this.suhuTanah,
    required this.ph,
  });

  int user;
  String cahaya;
  String kelembapanTanah;
  String kelembapanUdara;
  String suhuUdara;
  String suhuTanah;
  String ph;

  factory IndicatorItem.fromJson(Map<String, dynamic> json) => IndicatorItem(
        user: json["user"],
        cahaya: json["cahaya"],
        kelembapanTanah: json["kelembapan_tanah"],
        kelembapanUdara: json["kelembapan_udara"],
        suhuUdara: json["suhu_udara"],
        suhuTanah: json["suhu_tanah"],
        ph: json["ph"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "cahaya": cahaya,
        "kelembapan_tanah": kelembapanTanah,
        "kelembapan_udara": kelembapanUdara,
        "suhu_udara": suhuUdara,
        "suhu_tanah": suhuTanah,
        "ph": ph,
      };
}
