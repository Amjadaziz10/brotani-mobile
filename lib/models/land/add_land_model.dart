import 'dart:convert';

AddLandModel addLandFromJson(String str) =>
    AddLandModel.fromJson(json.decode(str));

String addLandToJson(AddLandModel data) => json.encode(data.toJson());

class AddLandModel {
  AddLandModel({
    required this.status,
    required this.message,
  });

  int status;
  String message;

  factory AddLandModel.fromJson(Map<String, dynamic> json) => AddLandModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
