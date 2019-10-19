import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/categories_screen.dart';
import 'package:flutter_complete_guide/screens/favorites_sceen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(

            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category,
                ),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star,
                ),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          CategoriesScreen(),
          FavoritesScreen(),
        ],),
      ),
    );
  }
}
