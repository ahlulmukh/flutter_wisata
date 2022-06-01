import 'package:flutter_tugas_akhir/models/category_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';

class ProductModel {
  int id;
  String name;
  double weight;
  int stock;
  int price;
  String? image;
  String description;
  TokoModel? market;
  CategoryModel? category;

  ProductModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.stock,
    required this.price,
    required this.image,
    required this.description,
    required this.market,
    required this.category,
  });

  factory ProductModel.formJson(Map<String, dynamic> object) {
    return ProductModel(
      id: object['id'],
      name: object['name'],
      weight: double.parse(object['weight'].toString()),
      stock: int.parse(object['stock'].toString()),
      price: int.parse(object['price'].toString()),
      // ignore: unnecessary_null_in_if_null_operators, unnecessary_null_comparison
      image: object != null ? object['image'] : null,
      description: object['description'],
      market:
          object['store'] != null ? TokoModel.fromJson(object['store']) : null,
      category: object['category'] != null
          ? CategoryModel.fromJson(object['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'stock': stock,
      'price': price,
      'image': image,
      'decription': description,
      'store': market,
      'category': category,
    };
  }
}
