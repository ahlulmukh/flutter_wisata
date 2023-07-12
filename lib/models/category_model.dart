import 'package:flutter_tugas_akhir/models/product_model.dart';

class CategoryModel {
  int id;
  String name;
  List<ProductModel?> tickets;

  CategoryModel({required this.id, required this.name, required this.tickets});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      tickets: json['tickets'] != null
          ? List.from(json['tickets'])
              .map((tickets) => ProductModel.fromJson(tickets))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'products': tickets.map((tickets) => tickets?.id).toList(),
    };
  }
}
