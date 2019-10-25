import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/src/modules/bloc/category_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:meals/src/modules/bloc/category_events.dart';
import 'package:meals/src/modules/bloc/category_states.dart';

import 'package:meals/resources/dummy_data.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meals/src/services/models/meal.dart';
import 'package:meals/src/ui/error/error_screen.dart';
import 'package:meals/src/ui/widgets/loading_indicator.dart';
import 'package:meals/src/ui/screens/categories_screen.dart';
import 'package:meals/src/ui/screens/category_meals_screen.dart';
import 'package:meals/src/ui/screens/filters_screen.dart';
import 'package:meals/src/ui/screens/meal_detail_screen.dart';
import 'package:meals/src/ui/screens/tabs_screen.dart';

class MealsApp extends StatefulWidget {
  static const routeName = '/meals_app';

  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {

  CategoryBloc _categoryBloc;
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  List<Category> categories = [];

  @override
  void initState() {
    _categoryBloc = kiwi.Container().resolve<CategoryBloc>()
      ..dispatch(FetchCategoriesEvent());
    super.initState();
  }

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

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

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) =>
    meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
            DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  Widget _buildState(BuildContext context, CategoryState state) {
    if (state is CategoryLoadingState)
      return LoadingIndicator();
    else if (state is CategoryErrorState)
      return _buildErrorScreen(context, state.error);
    else if (state is CategoryLoadedState)
      return _buildContent(context, state.categories);
    else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder(
        bloc: _categoryBloc,
        builder: _buildState,
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Category> categories) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData
            .light()
            .textTheme
            .copyWith(
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
      initialRoute: '/',
      routes: {
        MealsApp.routeName: (context) => MealsApp(),
        '/': (ctx) => TabsScreen(_favoriteMeals, categories),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters, categories),
        CategoriesScreen.routeName: (context) => CategoriesScreen(categories),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => CategoriesScreen(categories));
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => CategoriesScreen(categories));
      },
    );
  }

  Widget _buildErrorScreen(BuildContext context, Exception exception) {
    return ErrorScreen(
      exception: exception,
      onRetry: () {
        _categoryBloc.dispatch(FetchCategoriesEvent());
      },
    );
  }
}
