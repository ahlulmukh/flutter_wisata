import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class TokoService {
  var dio = Dio();

  Future<List<TokoModel>> getMarkets() async {
    try {
      var response = await dio.get(Service.apiUrl + '/markets',
          options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
          ));
      print(response.data);
      if (response.statusCode == 200) {
        List data = response.data['data'] ?? [];
        List<TokoModel> markets =
            data.map((market) => TokoModel.fromJson(market)).toList();
        return markets;
      } else {
        throw Exception('Tidak ada toko ditampilkan');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TokoModel>> getMarketLimits() async {
    try {
      var response = await dio.get(Service.apiUrl + '/limitsMarket',
          options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
          ));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((market) => TokoModel.fromJson(market))
            .toList();
      } else {
        throw Exception('Gagal ambil data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TokoModel> fetchProfileToko({required int id}) async {
    try {
      Response response = await dio.get(Service.apiUrl + '/market/$id',
          options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
          ));
      if (response.statusCode == 200) {
        print(response.data);
        return TokoModel.fromJson(response.data['data']);
      } else {
        throw Exception('Gagal ambil data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TokoModel> updateProfileToko(
    int id,
    String usersId,
    String nameStore,
    String village,
    String address,
    String description,
    String accountName,
    String accountNumber,
    File image,
  ) async {
    try {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
      FormData formData = FormData.fromMap(
        {
          'users_id': usersId,
          'name_store': nameStore,
          'village': village,
          'address': address,
          'description': description,
          'account_name': accountName,
          'account_number': accountNumber,
          'image': await MultipartFile.fromFile(
            image.path,
            contentType: MediaType(
              mimeTypeData![0],
              mimeTypeData[1],
            ),
          ),
        },
      );
      var response = await dio.post(Service.apiUrl + '/updateMarket/$id',
          data: formData,
          options: Options(
            headers: {
              "Accept": "application/json;utf-8",
              "Content-Type": "multipart/form-data",
            },
            followRedirects: false,
            validateStatus: (status) => true,
          ));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return TokoModel.fromJson(response.data['data']);
      } else {
        throw Exception('Gagal update toko');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TokoModel> createToko({
    required int usersId,
    required String nameStore,
    required String village,
    required String address,
    required String description,
    required String accountName,
    required String accountNumber,
    required File image,
  }) async {
    try {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
      FormData formData = FormData.fromMap(
        {
          'users_id': usersId,
          'name_store': nameStore,
          'village': village,
          'address': address,
          'description': description,
          'account_name': accountName,
          'account_number': accountNumber,
          'image': await MultipartFile.fromFile(image.path,
              contentType: MediaType(mimeTypeData![0], mimeTypeData[1])),
        },
      );
      var response = await dio.post(Service.apiUrl + '/createMarket',
          options: Options(
            headers: {
              "Accept": "application/json;utf-8",
              "Content-Type": "multipart/form-data",
            },
            followRedirects: false,
            validateStatus: (status) => true,
          ),
          data: formData);
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return TokoModel.fromJson(response.data['data']);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
