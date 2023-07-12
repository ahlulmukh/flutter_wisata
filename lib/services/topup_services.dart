import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopupService {
  var dio = Dio();

  Future<bool> topup({
    required String saldo,
    required File image,
  }) async {
    try {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      FormData formData = FormData.fromMap(
        {
          'saldo': saldo,
          'image': await MultipartFile.fromFile(
            image.path,
            contentType: MediaType(
              mimeTypeData![0],
              mimeTypeData[1],
            ),
          ),
          'status': 'PENDING'
        },
      );
      var response = await dio.post(Service.apiUrl + '/topup',
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json",
            },
            followRedirects: false,
            validateStatus: (status) => true,
          ),
          data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Gagal Melakukan Checkout!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
