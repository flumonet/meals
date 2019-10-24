import 'package:flutter/material.dart';
import 'package:meals/src/modules/local_io/local_storage.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meals/src/ui/screens/favorites_sceen.dart';
import 'package:meals/src/ui/widgets/main_drawer.dart';
import 'package:meals/src/services/models/meal.dart';
import 'package:meals/src/ui/screens/categories_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  List<Category> categories;


  TabsScreen(this.favoriteMeals, this.categories);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
    {'page': CategoriesScreen(widget.categories), 'title': 'Categories'},
    {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Your Favorites'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context).settings.arguments as String;
    if (categoryId != null) {
      widget.categories.removeWhere((e) {
        return e.id == categoryId;
      });
      LocalStorage().writeContent(widget.categories);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
        ),
      ),
      drawer: MainDrawer(),

      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text('Categories')),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text('Favorites')),
        ],
      ),
    );
  }
}
