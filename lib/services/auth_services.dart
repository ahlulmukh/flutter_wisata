import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  var dio = Dio();

  Future<UserModel> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      if (token != null) {
        var response = await dio.get(
          Service.apiUrl + '/user',
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
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
    try {
      FormData formData = FormData.fromMap(
        {
          'email': email,
          'password': password,
        },
      );
      var response = await dio.post(Service.apiUrl + '/login',
          options: Options(
            headers: {
              "Accept": "application/json;utf-8",
            },
            followRedirects: false,
            validateStatus: (status) => true,
          ),
          data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        UserModel user = UserModel.fromJson(response.data['data']['user']);
        user.token = 'Bearer ' + response.data['data']['access_token'];
        prefs.setString('token', user.token.toString());
        return user;
      } else {
        throw Exception('Gagal login');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'username': username,
        'email': email,
        'password': password
      });
      var response = await dio.post(Service.apiUrl + '/register',
          options: Options(
            headers: {'Content-Type': 'aplication/json'},
            followRedirects: false,
            validateStatus: (status) => true,
          ),
          data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        final pref = await SharedPreferences.getInstance();
        UserModel user = UserModel.fromJson(response.data['data']['user']);
        user.token = 'Bearer ' + response.data['data']['access_token'];
        pref.setString('token', user.token.toString());
        return user;
      } else {
        throw Exception('Gagal register');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
