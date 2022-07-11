import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class CheckoutService {
  var dio = Dio();

  Future<bool> checkout({
    required String address,
    required List<CartModel> carts,
    required String phone,
    required File image,
    required double totalPrice,
    required String storeId,
  }) async {
    try {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      FormData formData = FormData.fromMap(
        {
          'address': address,
          'items': carts
              .map((cart) => {
                    'id': cart.product!.id,
                    'quantity': cart.quantity,
                  })
              .toList(),
          'phone': phone,
          'image': await MultipartFile.fromFile(
            image.path,
            contentType: MediaType(
              mimeTypeData![0],
              mimeTypeData[1],
            ),
          ),
          'total_price': totalPrice,
          'store_id': storeId,
          'status': 'PENDING'
        },
      );
      var response = await dio.post(Service.apiUrl + '/checkout',
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
