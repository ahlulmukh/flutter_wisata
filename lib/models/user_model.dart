import 'package:flutter_tugas_akhir/models/toko_model.dart';

class UserModel {
  int id;
  String name;
  String username;
  String email;
  String profilePhotoUrl;
  String token;
  TokoModel? toko;

  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.profilePhotoUrl,
      required this.token,
      required this.toko});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profilePhotoUrl: json['profile_photo_url'] ?? '',
      token: json['token'].toString(),
      toko: json['store'] != null ? TokoModel.fromJson(json['store']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
      'store': toko,
    };
  }
}
