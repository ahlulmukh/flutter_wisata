import 'package:flutter_tugas_akhir/models/category_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? lokasi;
  String? description;
  int? price;
  String? image;
  CategoryModel? category;

  ProductModel({
    required this.id,
    required this.name,
    required this.lokasi,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  ProductModel.fromJson(Map<String, dynamic> object) {
    id = object['id'];
    name = object['name'];
    lokasi = object['lokasi'];
    description = object['description'];
    price = object['price'];
    // ignore: unnecessary_null_in_if_null_operators, unnecessary_null_comparison
    image = object != null ? object['image'] : null;
    category = object['category'] != null
        ? CategoryModel.fromJson(object['category'])
        : CategoryModel.fromJson({});
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lokasi': lokasi,
      'description': description,
      'price': price,
      'image': image,
      'decription': description,
      'category': category,
    };
  }
}
