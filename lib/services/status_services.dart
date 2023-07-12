import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTopUpStatus {
  var dio = Dio();

  Future<String> getStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var response = await dio.get(
        Service.apiUrl + '/get-topup-status',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        return data['status'];
      } else {
        throw Exception('Failed to get top up status');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
