import 'package:flutter/foundation.dart';
import 'package:flutter_tugas_akhir/models/category_model.dart';
import 'package:flutter_tugas_akhir/services/category_services.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel?> _categories = [];
  CategoryModel? _category;

  List<CategoryModel?> get categories => _categories;
  CategoryModel? get category => _category;

  set categories(List<CategoryModel?> categories) {
    _categories = categories;
    notifyListeners();
  }

  set category(CategoryModel? category) {
    _category = category;
    notifyListeners();
  }

  Future<bool> getCategory({required int id}) async {
    try {
      CategoryModel category = await CategoryServices().category(id: id);
      _category = category;
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getCategories() async {
    try {
      List<CategoryModel> categories = await CategoryServices().getCategories();
      _categories = categories;
    } catch (e) {
      throw Exception(e);
    }
  }
}
