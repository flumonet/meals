import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meals/src/modules/local_io/local_storage.dart';
import 'package:meals/src/services/api/api_timeout.dart';
import 'package:meals/src/services/api/categories_service.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meals/src/services/models/category_response.dart';

class CategoriesApiService implements CategoriesService {
  final http.Client client;
  static const request = 'https://graphql-pokemon.now.sh/?query={pokemons(first: 50){id, number, name, weight{minimum,maximum}, weaknesses, resistant, fleeRate, maxHP, image}}';

  CategoriesApiService(this.client) : assert(client != null);

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
