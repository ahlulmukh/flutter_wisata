import 'package:flutter_tugas_akhir/models/product_model.dart';

class CategoryModel {
  int id;
  String name;
  List<ProductModel?> products;

  CategoryModel({required this.id, required this.name, required this.products});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      products: json['products'] != null
          ? List.from(json['products'])
              .map((products) => ProductModel.formJson(products))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'products': products.map((products) => products?.id).toList(),
    };
  }
}
