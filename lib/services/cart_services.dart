import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  var dio = Dio();

  Future<void> deleteAllCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await dio.delete(
      Service.apiUrl + '/deleteAllCart',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );
    print(response.data);
  }

  Future<CartModel> cart({
    required String id,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await dio.get(
        Service.apiUrl + '/cart/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return CartModel.fromJson(response.data['data'] ?? {});
      } else {
        throw Exception('Gagal ambil data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteCart(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await dio.delete(
      Service.apiUrl + '/deleteCart/$id',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );
    print(response.data);
  }

  Future<void> updateCart(int id, dynamic quantity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var data = {
        'quantity': quantity,
      };
      var response = await dio.put(Service.apiUrl + '/updateCart/$id',
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            followRedirects: false,
            validateStatus: (status) => true,
          ),
          data: data);
      print(response.data);
      CartModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CartModel>> getMyCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await dio.get(
        Service.apiUrl + '/myCart',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        List data = response.data['data'] ?? [];
        List<CartModel> carts =
            data.map((cart) => CartModel.fromJson(cart)).toList();
        return carts;
      } else {
        throw 'Tidak ada data';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CartModel> addCart({
    required String userId,
    required dynamic productId,
    required dynamic quantity,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      FormData formData = FormData.fromMap({
        'users_id': userId,
        'product_id': productId,
        'quantity': quantity,
      });
      var response = await dio.post(
        Service.apiUrl + '/addCart',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) => true,
        ),
        data: formData,
      );
      print(response.data);
      if (response.statusCode == 200) {
        return CartModel.fromJson(response.data['data']);
      } else {
        throw Exception('Gagal tambah item');
      }
    } on DioError catch (e) {
      print(e.response!.data);
      print(e.response!.headers);
      print(e.response!.isRedirect);
      print(e.message);
      print(e.error);
      throw Exception(e);
    }
  }
}
