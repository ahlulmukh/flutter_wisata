// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:flutter_tugas_akhir/models/toko_model.dart';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? profilePhotoPath;
  String? token;
  TokoModel? toko;

  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.profilePhotoPath,
      required this.token,
      required this.toko});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? null,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profilePhotoPath: json['profile_photo_path'],
      token: json['token'].toString(),
      toko: json['store'] != null
          ? TokoModel.fromJson(json['store'])
          : TokoModel.fromJson({}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'profile_photo_path': profilePhotoPath,
      'token': token,
      'store': toko,
    };
  }
}
