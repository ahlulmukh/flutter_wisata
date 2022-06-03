import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';

class ProductService {
  var dio = Dio();

  Future<List<ProductModel>> getProductSeacrh({required String data}) async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/search/$data',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((products) => ProductModel.formJson(products))
            .toList();
      } else {
        throw Exception('Data tidak ditemukan');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/products',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      return (response.data['data'] as List)
          .map((products) => ProductModel.formJson(products))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProductModel> getProduct({required int id}) async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/product/$id',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return ProductModel.formJson(response.data['data']);
      } else {
        throw Exception('Gagal ambil data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProductModel>> getProductLimit() async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/limits',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      return (response.data['data'] as List)
          .map((product) => ProductModel.formJson(product))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
