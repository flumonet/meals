import 'dart:async';
import 'package:meals/src/modules/local_io/local_storage.dart';
import 'package:meals/src/services/api/categories_service.dart';
import 'package:meals/src/services/models/category.dart';

class CategoriesApiService implements CategoriesService {

  @override
  Future<List<Category>> fetchCategories() async {
    final categories = await LocalStorage().readContent();
    if (categories != null) {
      return categories;
    } else {
      throw Exception('Problem loading data');
    }
  }
}
