import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/services/product_services.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel?> _product = [];
  ProductModel? _getProduct;

  ProductModel? get getProduct => _getProduct;
  List<ProductModel?> get product => _product;

  set product(List<ProductModel?> product) {
    _product = product;
    notifyListeners();
  }

  set getProduct(ProductModel? getProduct) {
    _getProduct = getProduct!;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> product = await ProductService().getProducts();
      _product = product;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getProductSeacrh({required String data}) async {
    try {
      List<ProductModel> product =
          await ProductService().getProductSeacrh(data: data);
      _product = product;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> getProductId({required int id}) async {
    try {
      ProductModel getProduct = await ProductService().getProduct(id: id);
      _getProduct = getProduct;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getProductLimit() async {
    try {
      List<ProductModel> product = await ProductService().getProductLimit();
      _product = product;
    } catch (e) {
      throw Exception(e);
    }
  }
}
