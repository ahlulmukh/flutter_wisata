import 'package:flutter_tugas_akhir/models/category_model.dart';
import 'package:flutter_tugas_akhir/models/toko_model.dart';

class ProductModel {
  int? id;
  String? name;
  num? weight;
  dynamic stock;
  int? price;
  String? image;
  String? description;
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

  ProductModel.fromJson(Map<String, dynamic> object) {
    id = object['id'];
    name = object['name'];
    weight = object['weight'];
    stock = object['stock'];
    price = object['price'];
    // ignore: unnecessary_null_in_if_null_operators, unnecessary_null_comparison
    image = object != null ? object['image'] : null;
    description = object['description'];
    market = object['store'] != null
        ? TokoModel.fromJson(object['store'])
        : TokoModel.fromJson({});
    category = object['category'] != null
        ? CategoryModel.fromJson(object['category'])
        : CategoryModel.fromJson({});
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
