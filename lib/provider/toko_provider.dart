import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/services/toko_services.dart';

class TokoProvider with ChangeNotifier {
  TokoModel? _toko;

  TokoModel? get toko => _toko;

  set toko(TokoModel? toko) {
    _toko = toko;
    notifyListeners();
  }

  Future<bool> fetchToko({required int id}) async {
    try {
      TokoModel toko = await TokoService().fetchProfileToko(id: id);
      _toko = toko;
      return true;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> updateProfileToko({
    required int id,
    required int usersId,
    required String nameStore,
    required String village,
    required String address,
    required String description,
    required String accountName,
    required int accountNumber,
    // required File image,
  }) async {
    try {
      TokoModel toko = await TokoService().updateProfileToko(
        id: id,
        usersId: usersId,
        nameStore: nameStore,
        village: village,
        address: address,
        description: description,
        accountName: accountName,
        accountNumber: accountNumber,
        // image: image,
      );
      _toko = toko;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createToko({
    required int usersId,
    required String nameStore,
    required String village,
    required String address,
    required String description,
    required String accountName,
    required int accountNumber,
  }) async {
    try {
      TokoModel toko = await TokoService().createToko(
        usersId: usersId,
        nameStore: nameStore,
        village: village,
        address: address,
        description: description,
        accountName: accountName,
        accountNumber: accountNumber,
      );
      _toko = toko;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
