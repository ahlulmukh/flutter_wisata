import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/order_item_model.dart';
import 'package:flutter_tugas_akhir/models/order_model.dart';
import 'package:flutter_tugas_akhir/services/order_services.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel>? _orders = []; // LIST
  OrderModel? _order; // MAPPING

  List<OrderItemModel>? _ordersItem = [];
  OrderItemModel? _orderItem;

  OrderModel? get order => _order;
  List<OrderModel>? get orders => _orders;

  OrderItemModel? get orderItem => _orderItem;
  List<OrderItemModel>? get ordersItem => _ordersItem;

  set orders(List<OrderModel>? orders) {
    _orders = orders;
    notifyListeners();
  }

  set order(OrderModel? order) {
    _order = order;
    notifyListeners();
  }

  set ordersItem(List<OrderItemModel>? ordersItem) {
    _ordersItem = ordersItem;
    notifyListeners();
  }

  set orderItem(OrderItemModel? orderItem) {
    _orderItem = orderItem;
    notifyListeners();
  }

  Future<void> orderUser({required int id}) async {
    try {
      List<OrderModel> orders = await OrderService().userOrder(id: id);
      _orders = orders;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> orderMarket({required int id}) async {
    try {
      List<OrderModel>? orders = await OrderService().marketOrder(id: id);
      _orders = orders;
    } catch (e) {
      throw Exception(e);
    }
  }

  void statusOrder(int id, String status) async {
    try {
      int index = _orders!.indexWhere((element) => element.id == id);
      if (status != '') {
        _orders![index].status;
        await OrderService().statusOrder(id: id, status: status);
      }
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
