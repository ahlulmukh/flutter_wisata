// ignore_for_file: prefer_if_null_operators

import 'package:flutter_tugas_akhir/models/order_item_model.dart';
import 'package:flutter_tugas_akhir/models/user_model.dart';

enum OrderStatus { pending, progress, delivery, cancel, success }

class OrderModel {
  int? id;
  String? nama;
  String? nameticket;
  String? qrcodeurl;
  String? strukurl;
  int? usersId;
  int? quantities;
  OrderStatus? status;
  double? totalPrice;
  DateTime? createdAT;
  List<OrderItemModel>? orderItem;
  UserModel? user;

  OrderModel({
    required this.id,
    required this.nama,
    required this.nameticket,
    required this.qrcodeurl,
    required this.strukurl,
    required this.usersId,
    required this.status,
    required this.totalPrice,
    required this.createdAT,
    required this.orderItem,
    required this.user,
    required this.quantities,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        nama: json['nama'] ?? '',
        nameticket: json['name_ticket'] ?? '',
        quantities: json['quantities'] ?? '',
        qrcodeurl: json['qrcode_url'] != null ? json['qrcode_url'] : null,
        strukurl: json['struk_url'] != null ? json['struk_url'] : null,
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
      'nama': nama,
      'name_ticket': nameticket,
      'qrcode_url': qrcodeurl,
      'struk_url': strukurl,
      'users_id': usersId,
      'status': status,
      'total_price': totalPrice,
      'created_at': createdAT,
      'order_item': orderItem?.map((order) => order).toList(),
    };
  }
}
