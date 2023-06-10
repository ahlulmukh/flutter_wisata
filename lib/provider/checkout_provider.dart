import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
import 'package:flutter_tugas_akhir/services/checkout_services.dart';

class CheckoutProvider with ChangeNotifier {
  Future<bool> checkout({
    required String address,
    required List<CartModel> carts,
    required String phone,
    required File image,
    required double totalPrice,
  }) async {
    try {
      if (await CheckoutService().checkout(
        address: address,
        carts: carts,
        phone: phone,
        image: image,
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
