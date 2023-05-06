import 'package:brotani/models/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../shared/api_url.dart';

abstract class ILogin {
  Future<LoginModel?> login(String email, String password) async {
    final api = '${baseUrl}login';
    final data = {"email": email, "password": password};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      return LoginModel(email: email, token: body['access']);
    } else {
      return null;
    }
  }

  Future<LoginModel?> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    final email = storage.getString('EMAIL');
    if (token != null && email != null) {
      return LoginModel(email: email, token: token);
    } else {
      return null;
    }
  }

  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return true;
  }
}
