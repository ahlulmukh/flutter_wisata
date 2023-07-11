import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutService {
  var dio = Dio();

  Future<bool> checkout({
    required List<CartModel> carts,
    required String nama,
    required double totalPrice,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      FormData formData = FormData.fromMap(
        {
          'items': carts
              .map((cart) => {
                    'id': cart.product!.id,
                    'quantity': cart.quantity,
                  })
              .toList(),
          'nama': nama,
          'total_price': totalPrice,
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
