import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/services/checkout_services.dart';

class CheckoutProvider with ChangeNotifier {
  Future<bool> checkout({
    required List<CartModel> carts,
    required String nama,
    required double totalPrice,
  }) async {
    try {
      if (await CheckoutService().checkout(
        carts: carts,
        nama: nama,
        totalPrice: totalPrice,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
