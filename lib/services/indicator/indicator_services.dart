import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/indicator/indicator_model.dart';
import '../../shared/api_url.dart';

class IndicatorServices {
  final _dio = Dio();

  Future<List<IndicatorItem>> getIndicatorList() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    Indicator indicator;
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      Response userData = await _dio.get('$baseUrl/temperatur/list_temperatur');
      indicator = Indicator.fromJson(userData.data);
      return indicator.data;
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
