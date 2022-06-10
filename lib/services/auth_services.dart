import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  var dio = Dio();

  Future<UserModel> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      if (token != null) {
        Response response = await dio.get(
          Service.apiUrl + '/user',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) => true,
          ),
        );
        print(response.statusCode);
        print(response.data);
        if (response.statusCode == 200) {
          UserModel user = UserModel.fromJson(response.data['data'][0]);
          return user;
        } else {
          throw Exception('Gagal ambil data profil');
        }
      } else {
        return UserModel.fromJson({});
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token')!;
      Response response = await dio.post(
        Service.apiUrl + '/logout',
        options: Options(
          headers: {
            "Accept": "application/json;utf-8",
            'Authorization': token,
          },
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        await prefs.remove('token');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(Service.apiUrl + '/login');
    var header = {'Content-Type': 'aplication/json'};
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(url, headers: header, body: body);
    print(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(response.body)['data'];
      data['store'] =
          data['store'] != null ? TokoModel.fromJson(data['store']) : null;
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      prefs.setString('token', user.token.toString());
      print(prefs.getString('token'));
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(Service.apiUrl + '/register');
    var header = {'Content-Type': 'aplication/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password
    });
    var response = await http.post(url, headers: header, body: body);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal register');
    }
  }
}
