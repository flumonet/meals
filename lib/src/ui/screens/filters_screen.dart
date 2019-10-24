import 'package:flutter/material.dart';
import 'package:meals/app/app.dart';
import 'package:meals/resources/dummy_data.dart';
import 'package:meals/src/modules/local_io/local_storage.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meals/src/ui/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> currentFilters;
  final Function saveFilters;
  final List<Category> categories;

  FiltersScreen(this.currentFilters, this.saveFilters, this.categories);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  void _recoverDatabase() {
    LocalStorage().writeContent(dummyCategories);
    Navigator.of(context).pushNamed(MealsApp.routeName);
  }

  Widget _buildSwitchListTile(String title,
      String description,
      bool currentValue,
      Function updateValue,) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme
                  .of(context)
                  .textTheme
                  .title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                      (newValue) {
                    setState(
                          () {
                        _glutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                      (newValue) {
                    setState(
                          () {
                        _lactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegeterian',
                  'Only include Vegeterian meals.',
                  _vegetarian,
                      (newValue) {
                    setState(
                          () {
                        _vegetarian = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals.',
                  _vegan,
                      (newValue) {
                    setState(
                          () {
                        _vegan = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(60),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    'Recover database',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead,
                  ),
                  color: Theme
                      .of(context)
                      .primaryColorLight,
                  onPressed: _recoverDatabase,
                  textColor: Theme
                      .of(context)
                      .textTheme
                      .button
                      .color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
