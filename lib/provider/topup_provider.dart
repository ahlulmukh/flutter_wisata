import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/services/topup_services.dart';

class TopupProvider with ChangeNotifier {
  Future<bool> topup({
    required String saldo,
    required File image,
  }) async {
    try {
      if (await TopupService().topup(
        saldo: saldo,
        image: image,
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
