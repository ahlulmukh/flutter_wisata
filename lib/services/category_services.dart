import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/category_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';

class CategoryServices {
  var dio = Dio();

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/categories',
        options: Options(
          followRedirects: false,
          validateStatus: ((status) => true),
        ),
      );
      print(response.statusCode);
      return (response.data['data'] as List)
          .map((categories) => CategoryModel.fromJson(categories))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CategoryModel> category({required int id}) async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/category/$id',
        options:
            Options(followRedirects: false, validateStatus: (status) => true),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(response.data['data']);
      } else {
        throw Exception('Gagal ubah data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
