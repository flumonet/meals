import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable(explicitToJson: true)
class Cat {
  String id;
  String title;
  int color;

  Cat({this.id, this.title, this.color});

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);
}
