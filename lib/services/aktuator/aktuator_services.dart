import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/api_url.dart';

class AktuatorServices {
  final _dio = Dio();

  Future<bool> onAktuatorKelembabanTanah() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final id = storage.getInt('ID');
    final data = {"kipas_angin": true, "pompa_air": true};
    _dio.options.headers['content-Type'] = 'application/json';

    try {
      Response response = await _dio.post(
        '$baseUrl/aktuator/$id',
        data: data,
      );
      print("on berhasil");
      return true;
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
      return false;
    }
  }

  Future<bool> offAktuatorKelembabanTanah() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final id = storage.getInt('ID');
    final data = {"kipas_angin": false, "pompa_air": false};
    _dio.options.headers['content-Type'] = 'application/json';

    try {
      Response response = await _dio.post(
        '$baseUrl/aktuator/$id',
        data: data,
      );

      print("off berhasil");
      return true;
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
      return false;
    }
  }
}
