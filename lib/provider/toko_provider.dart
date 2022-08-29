import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';
import 'package:flutter_tugas_akhir/services/toko_services.dart';

class TokoProvider with ChangeNotifier {
  TokoModel? _toko;
  List<TokoModel?> _markets = [];

  TokoModel? get toko => _toko;
  List<TokoModel?> get markets => _markets;

  set markets(List<TokoModel?> markets) {
    _markets = markets;
    notifyListeners();
  }

  set toko(TokoModel? toko) {
    _toko = toko;
    notifyListeners();
  }

  Future<void> getMarketsLimit() async {
    try {
      List<TokoModel> markets = await TokoService().getMarketLimits();
      _markets = markets;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getMarkets() async {
    try {
      List<TokoModel> markets = await TokoService().getMarkets();
      _markets = markets;
    } catch (e) {
      throw Exception(e);
    }
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

  Future<bool> updateProfileToko(
      int id,
      String usersId,
      String nameStore,
      String village,
      String address,
      String description,
      String accountName,
      String accountNumber,
      {required File image}) async {
    try {
      TokoModel toko = await TokoService().updateProfileToko(
        id,
        usersId,
        nameStore,
        village,
        address,
        description,
        accountName,
        accountNumber,
        image,
      );
      _toko = toko;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createToko(
      {required int usersId,
      required String nameStore,
      required String village,
      required String address,
      required String description,
      required String accountName,
      required String accountNumber,
      required File image}) async {
    try {
      TokoModel toko = await TokoService().createToko(
        usersId: usersId,
        nameStore: nameStore,
        village: village,
        address: address,
        description: description,
        accountName: accountName,
        accountNumber: accountNumber,
        image: image,
      );
      _toko = toko;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
