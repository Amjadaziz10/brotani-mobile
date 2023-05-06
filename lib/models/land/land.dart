import 'dart:convert';

Land landFromJson(String str) => Land.fromJson(json.decode(str));

String landToJson(Land data) => json.encode(data.toJson());

class Land {
  Land({
    required this.data,
  });

  List<LandItem> data;

  factory Land.fromJson(Map<String, dynamic> json) => Land(
        data:
            List<LandItem>.from(json["data"].map((x) => LandItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LandItem {
  LandItem({
    required this.user,
    required this.nameGreenhouse,
    required this.addressGreenhouse,
    required this.luas,
    required this.komoditas,
    required this.bibit,
    required this.long,
    required this.lat,
    this.imgGreenhouse,
    required this.nib,
    required this.mitra,
    required this.createdAt,
    required this.updateAt,
  });

  int user;
  String nameGreenhouse;
  String addressGreenhouse;
  String luas;
  String komoditas;
  String bibit;
  double long;
  double lat;
  dynamic imgGreenhouse;
  String nib;
  String mitra;
  DateTime createdAt;
  DateTime updateAt;

  factory LandItem.fromJson(Map<String, dynamic> json) => LandItem(
        user: json["user"],
        nameGreenhouse: json["nameGreenhouse"],
        addressGreenhouse: json["addressGreenhouse"],
        luas: json["luas"],
        komoditas: json["komoditas"],
        bibit: json["jml_bibit"],
        long: json["long"]?.toDouble() ?? 0.0,
        lat: json["lat"]?.toDouble() ?? 0.0,
        imgGreenhouse: json["imgGreenhouse"],
        nib: json["nib"],
        mitra: json["mitra"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "nameGreenhouse": nameGreenhouse,
        "addressGreenhouse": addressGreenhouse,
        "luas": luas,
        "komoditas": komoditas,
        "jml_bibit": bibit,
        "long": long,
        "lat": lat,
        "imgGreenhouse": imgGreenhouse,
        "nib": nib,
        "mitra": mitra,
        "created_at": createdAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
      };
}
