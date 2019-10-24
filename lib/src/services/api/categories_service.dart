import 'package:meals/src/services/models/category.dart';

abstract class CategoriesService {
  Future<List<Category>> fetchCategories();
}
