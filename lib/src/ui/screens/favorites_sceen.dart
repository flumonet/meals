import 'package:flutter/material.dart';
import 'package:meals/src/services/models/meal.dart';

class FavoritesScreen extends StatelessWidget {
 final List<Meal> _favoritedMeals;


 FavoritesScreen(this._favoritedMeals);

 @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You have no favorites yet - start adding some!'),
    );
  }
}
