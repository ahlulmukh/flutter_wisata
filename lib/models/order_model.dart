// ignore_for_file: prefer_if_null_operators

import 'package:flutter_tugas_akhir/models/order_item_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';

enum OrderStatus { pending, progress, delivery, cancel, success }

class OrderModel {
  int? id;
  String? address;
  String? phone;
  String? image;
  String? qrcodeurl;
  int? usersId;
  OrderStatus? status;
  double? totalPrice;
  DateTime? createdAT;
  List<OrderItemModel>? orderItem;
  UserModel? user;

  OrderModel({
    required this.id,
    required this.address,
    required this.phone,
    required this.image,
    required this.qrcodeurl,
    required this.usersId,
    required this.status,
    required this.totalPrice,
    required this.createdAT,
    required this.orderItem,
    required this.user,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        address: json['address'] ?? '',
        phone: json['phone'] ?? '',
        image: json['image'] != null ? json['image'] : null,
        qrcodeurl: json['qrcode_url'] != null ? json['qrcode_url'] : null,
        usersId: int.parse(json['users_id'].toString()),
        status: (json['status'] == 'PENDING')
            ? OrderStatus.pending
            : (json['status'] == 'PROGRESS')
                ? OrderStatus.progress
                : (json['status'] == 'DELIVERY')
                    ? OrderStatus.delivery
                    : (json['status'] == 'CANCEL')
                        ? OrderStatus.cancel
                        : (json['status'] == 'SUCCESS')
                            ? OrderStatus.success
                            : null,
        totalPrice: double.parse(json['total_price'].toString()),
        createdAT: DateTime.parse(json['created_at'].toString()),
        orderItem: json['order_item'] != null
            ? List.from(json['order_item'])
                .map((order) => OrderItemModel.fromJson(order))
                .toList()
            : [],
        user: json['user'] != null
            ? UserModel.fromJson(json['user'])
            : UserModel.fromJson({}));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'phone': phone,
      'image': image,
      'qrcode_url': qrcodeurl,
      'users_id': usersId,
      'status': status,
      'total_price': totalPrice,
      'created_at': createdAT,
      'order_item': orderItem?.map((order) => order).toList(),
    };
  }
}
