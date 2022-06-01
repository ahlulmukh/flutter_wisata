import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/services/auth_services.dart';
import 'package:flutter_tugas_akhir/services/user_services.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> updateProfile({
    required int id,
    required String name,
    required String username,
    required String email,
  }) async {
    try {
      UserModel user = await UserService()
          .updateProfil(id: id, name: name, username: username, email: email);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await AuthService().logout();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getProfile() async {
    try {
      UserModel user = await AuthService().getProfile();
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(
      {required String name,
      required String username,
      required String email,
      required String password}) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
