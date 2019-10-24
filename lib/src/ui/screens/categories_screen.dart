import 'package:flutter/material.dart';
import 'package:meals/src/services/models/category.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories_screen';
  final List<Category> categories;

  CategoriesScreen(this.categories);

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(20),
        children: categories
            .map((catData) => CategoryItem(catData.id, catData.title, catData.color))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
      ),
    );
  }
}
