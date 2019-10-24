import 'package:json_annotation/json_annotation.dart';
import 'package:meals/src/services/models/cat.dart';
import 'package:meals/src/services/models/category.dart';

part 'cat_response.g.dart';

@JsonSerializable()
class CatResponse {
  final List<Cat> cats;

  CatResponse(this.cats);

  factory CatResponse.fromJson(Map<String, dynamic> json) =>
      _$CatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CatResponseToJson(this);
}