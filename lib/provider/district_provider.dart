import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/district_model.dart';
import 'package:flutter_tugas_akhir/services/district_services.dart';

class DistrictProvider with ChangeNotifier {
  List<DistrictModel?> _district = [];

  List<DistrictModel?> get district => _district;

  // String? _selectedItem;

  set district(List<DistrictModel?> district) {
    _district = district;
    notifyListeners();
  }

  Future<void> getdistricts() async {
    try {
      List<DistrictModel> district = await DistrictService().district();
      _district = district;
    } catch (e) {
      throw Exception(e);
    }
  }
}
