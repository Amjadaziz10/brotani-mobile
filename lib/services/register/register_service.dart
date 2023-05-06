import 'dart:convert';

import 'package:brotani/interfaces/register/register_interfaces.dart';
import 'package:brotani/models/register/register_model.dart';
import 'package:http/http.dart' as http;

import '../../shared/api_url.dart';

class RegisterService extends IRegister {
  @override
  Future<RegisterModel?> register(String userName, String email,
      String telephone, String address, String password) async {
    final api = Uri.parse('$baseUrl/register/');
    final data = {
      "username": userName,
      "email": email,
      "telephone": telephone,
      "address": address,
      "password": password
    };
    // final dio = Dio();
    http.Response response;
    response = await http.post(api, body: data);
    if (response.statusCode == 201) {
      final body = json.decode(response.body);
      return RegisterModel(status: body['status'], message: body['message']);
    }
    if (response.statusCode == 404) {
      final body = json.decode(response.body);
      return RegisterModel(status: body['status'], message: body['message']);
    } else {
      return null;
    }
  }
}
