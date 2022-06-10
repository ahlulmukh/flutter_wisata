import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class UserService {
  var dio = Dio();

  Future<UserModel> updateProfil({
    required int id,
    required String name,
    required String username,
    required String email,
    required File profilePhotoPath,
  }) async {
    try {
      final mimeTypeData =
          lookupMimeType(profilePhotoPath.path, headerBytes: [0xFF, 0xD8])
              ?.split('/');
      FormData formData = FormData.fromMap(
        {
          'id': id,
          'name': name,
          'username': username,
          'email': email,
          'profile_photo_path': await MultipartFile.fromFile(
              profilePhotoPath.path,
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1])),
        },
      );

      var response = await dio.post(
        Service.apiUrl + '/update/$id',
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
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
