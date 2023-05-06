import 'dart:io';
import 'package:brotani/models/land/add_land_model.dart';
import 'package:brotani/models/land/land.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/api_url.dart';

class LandService {
  final _dio = Dio();

  Future<List<LandItem>> getLandList() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    print("TOKEN: $token");
    Land land;
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer ${token}";

    try {
      Response userData = await _dio.get('$baseUrl/lahan/list_lahan');
      land = Land.fromJson(userData.data);
      return land.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
      throw Exception(e);
    }
  }

  Future<String> postLand(
      {required int id,
      required String name,
      required String address,
      required String luas,
      required String komoditas,
      required String bibit,
      required String long,
      required String lat,
      required File gambar,
      required String nib,
      required String mitra}) async {
    AddLandModel land;
    String fileName = gambar.path.split('/').last;
    print(fileName);

    FormData data = FormData.fromMap({
      "nameGreenhouse": name,
      "addressGreenhouse": address,
      "luas": luas,
      "komoditas": komoditas,
      "jml_bibit": bibit,
      "long": long,
      "lat": lat,
      "imgGreenhouse": await MultipartFile.fromFile(
        gambar.path,
        filename: fileName,
      ),
      "nib": nib,
      "mitra": mitra,
    });

    try {
      Response landData = await _dio.post('$baseUrl/lahan/$id', data: data);
      land = AddLandModel.fromJson(landData.data);
      return land.message;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
      throw Exception(e);
    }
  }
}
