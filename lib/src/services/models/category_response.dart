import 'package:json_annotation/json_annotation.dart';
import 'package:meals/src/services/models/category.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  final List<Category> categories;

  CategoriesResponse(this.categories);

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}