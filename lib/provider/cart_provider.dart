import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/cart_model.dart';
// import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/services/cart_services.dart';

class CartProvider with ChangeNotifier {
  CartModel? _cart;
  List<CartModel>? _cartList = [];

  CartModel? get cart => _cart;
  List<CartModel>? get cartList => _cartList;

  int get allCartItems => _cartList!.length;

  set cartList(List<CartModel>? cartList) {
    _cartList = cartList;
    notifyListeners();
  }

  set cart(CartModel? cart) {
    _cart = cart;
    notifyListeners();
  }

  Future<void> getCartList() async {
    try {
      List<CartModel> cartList = await CartService().getMyCart();
      _cartList = cartList;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getCart({required String id}) async {
    try {
      CartModel cart = await CartService().cart(id: id);
      _cart = cart;
      return true;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> removeAllCart() async {
    try {
      await CartService().deleteAllCart();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void removeCart(int id) async {
    await CartService().deleteCart(id);
    cartList!.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addQuantity(int id, dynamic quantity) async {
    await CartService().updateCart(id, quantity);
    int index = _cartList!.indexWhere((element) => element.id == id);
    _cartList![index].quantity++;
    notifyListeners();
  }

  totalPrice() {
    double total = 0;
    for (var item in _cartList!) {
      total += (item.quantity!.toInt() * item.product!.price!.toDouble());
    }
    return total;
  }

  totalItems() {
    int total = 0;
    for (var item in _cartList!) {
      total += item.quantity as int;
    }
    return total;
  }

  void reduceQuantity(int id, dynamic quantity) async {
    await CartService().updateCart(id, quantity);
    int index = _cartList!.indexWhere((element) => element.id == id);
    _cartList![index].quantity--;
    if (_cartList![index].quantity == 0) {
      await CartService().deleteCart(id);
      cartList!.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

  Future<void> addtoCart({
    required String userId,
    required String productId,
    required dynamic quantity,
  }) async {
    if (quantity == null) {
      await CartService().addCart(
        userId: userId,
        productId: productId,
        quantity: 1,
      );
    } else {
      _cart!.quantity++;
      await CartService().updateCart(
        _cart!.id!.toInt(),
        quantity + 1,
      );
    }
    notifyListeners();
  }
}
