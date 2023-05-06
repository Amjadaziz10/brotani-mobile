// import 'package:dio/dio.dart';
import 'package:brotani/models/login/login_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../interfaces/login/login_interfaces.dart';
import '../../models/user/user.dart';
import '../../shared/api_url.dart';

class LoginService extends ILogin {
  final _dio = Dio();

  @override
  Future<LoginModel?> login(String email, String password) async {
    final api = Uri.parse('$baseUrl/login');
    final data = {"email": email, "password": password};

    http.Response response;
    response = await http.post(api, body: data);
    if (response.statusCode == 200) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      final body = json.decode(response.body);
      final userData = await getUserData(token: body['access']);
      await storage.setInt('ID', userData.data[0].id);
      await storage.setString('TOKEN', body['access']);
      await storage.setString('EMAIL', userData.data[0].email);
      await storage.setString('USERNAME', userData.data[0].username);
      await storage.setString('TELEPHONE', userData.data[0].telephone);
      await storage.setString('ADDRESS', userData.data[0].address);
      return LoginModel(email: email, token: body['access']);
    } else {
      return null;
    }
  }

  @override
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

  @override
  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final email = storage.getString('EMAIL');
    final token = storage.getString('TOKEN');
    if (email != null && token != null) {
      await storage.remove('TOKEN');
      await storage.remove('EMAIL');
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUserData({required String token}) async {
    User user;
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer ${token}";

    try {
      Response userData = await _dio.get('$baseUrl/user/detail/');

      // Prints the raw data returned by the server
      print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      user = User.fromJson(userData.data);
      return user;
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
