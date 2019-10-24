import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:meals/resources/dummy_data.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meals/src/services/models/category_response.dart';
import 'package:path_provider/path_provider.dart';



class LocalStorage {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/categories.txt');
  }

  Future<List<Category>> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      var categories = CategoriesResponse.fromJson(json.decode(contents)).categories;
      return categories;
    } catch (e) {
      return dummyCategories;
    }
  }



  Future<File> writeContent(List<Category> categories) async {

    Map<String, dynamic> dataJson = CategoriesResponse(categories).toJson();

    final file = await _localFile;
    // Write the file
    var stCategories = jsonEncode(dataJson);
    return file.writeAsString(stCategories);
  }




}