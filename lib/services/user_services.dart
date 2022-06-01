import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';

class UserService {
  var dio = Dio();

  Future<UserModel> updateProfil({
    required int id,
    required String name,
    required String username,
    required String email,
  }) async {
    try {
      var body = jsonEncode(
        {
          'id': id,
          'name': name,
          'username': username,
          'email': email,
        },
      );
      var response = await dio.put(Service.apiUrl + '/update/$id', data: body);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception('Gagal ubah data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
