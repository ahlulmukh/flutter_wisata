import 'package:flutter_tugas_akhir/models/product_model.dart';

class OrderItemModel {
  int? id;
  int? price;
  dynamic quantity;
  String? orderId;
  ProductModel? product;

  OrderItemModel(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.orderId,
      required this.product});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      price: json['price'],
      quantity: json['quantity'],
      orderId: json['order_id'].toString(),
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : ProductModel.fromJson({}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'quantity': quantity,
      'order_id': orderId,
      'product': product,
    };
  }
}
