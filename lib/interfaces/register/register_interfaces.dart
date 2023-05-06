import 'package:brotani/models/register/register_model.dart';
import 'package:dio/dio.dart';

import '../../shared/api_url.dart';

abstract class IRegister {
  Future<RegisterModel?> register(String userName, String email,
      String telephone, String address, String password) async {
    final api = '${baseUrl}register/';
    final data = {
      "username": userName,
      "email": email,
      "telephone": telephone,
      "address": address,
      "password": password
    };
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 201) {
      final body = response.data;
      return RegisterModel(status: body['status'], message: body['message']);
    }
    if (response.statusCode == 404) {
      final body = response.data;
      return RegisterModel(status: body['status'], message: body['message']);
    } else {
      return null;
    }
  }
}
