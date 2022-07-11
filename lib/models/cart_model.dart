import 'package:flutter_tugas_akhir/models/product_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';

class CartModel {
  int id;
  dynamic usersId;
  dynamic productId;
  dynamic quantity;
  ProductModel? product;
  UserModel? user;

  CartModel({
    required this.id,
    required this.usersId,
    required this.productId,
    required this.quantity,
    required this.product,
    required this.user,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      usersId: int.parse(json['users_id'].toString()),
      productId: int.parse(json['product_id'].toString()),
      quantity: json['quantity'],
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : ProductModel.fromJson({}),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : UserModel.fromJson({}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'product_id': productId,
      'quantity': quantity,
      'product': product,
      'user': user,
    };
  }
}
