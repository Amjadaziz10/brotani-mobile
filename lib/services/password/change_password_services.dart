import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/indicator/indicator_model.dart';
import '../../shared/api_url.dart';

class ChangePasswordServices {
  final _dio = Dio();

  Future<String> putPassword(
    String password,
    String password2,
    String oldPassword,
  ) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    final id = storage.getInt('ID');
    final data = {
      "password": password,
      "password2": password2,
      "old_password": oldPassword,
    };
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      Response response = await _dio.put(
        '$baseUrl/change_password/$id/',
        data: data,
      );

      return "Password Berhasil Diubah";
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
      return "Password Lama Salah";
    }
  }
}
