import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meals/resources/dummy_data.dart';
import 'package:meals/src/services/models/cat.dart';
import 'package:meals/src/services/models/cat_response.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meals/src/services/models/category_response.dart';
import 'package:path_provider/path_provider.dart';



class LocalStorage {
  final List<Category> data = dummyCategories;


  // LocalStorage(this.data);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    print(directory.path);
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
      print('reading: '+contents);
      var categories = CategoriesResponse.fromJson(json.decode(contents)).categories;
      return categories;
    } catch (e) {
      // If encountering an error, return
      return null;
    }
  }



  Future<File> writeContent() async {

    Map<String, dynamic> dataJson = CategoriesResponse(data).toJson();

    final file = await _localFile;
    // Write the file
    var stCategories = jsonEncode(dataJson);
    print('writing: '+stCategories);
    return file.writeAsString(stCategories);
  }




}