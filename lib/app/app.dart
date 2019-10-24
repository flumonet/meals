import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:meals/src/modules/local_storage.dart';
import 'package:meals/resources/dummy_data.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meals/src/services/models/meal.dart';
import 'package:meals/src/ui/screens/categories_screen.dart';
import 'package:meals/src/ui/screens/category_meals_screen.dart';
import 'package:meals/src/ui/screens/filters_screen.dart';
import 'package:meals/src/ui/screens/meal_detail_screen.dart';
import 'package:meals/src/ui/screens/tabs_screen.dart';

class MealsApp extends StatefulWidget {
  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];
  List<Category> categories = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  void initState() {
//    LocalStorage().writeContent().then((value) => {
//          print('----InitState reading: ' +
//              LocalStorage()
//                  .readContent()
//                  .then((onValue) => {
//                        print('----InitState reading: ' + onValue.toString()),
//                      })
//                  .toString())
//        });
    categories = dummyCategories;
    LocalStorage().readContent().then((onValue) => {
          categories = onValue,
          print(onValue),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
//        home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoritedMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
