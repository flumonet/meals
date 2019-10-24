// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatResponse _$CatResponseFromJson(Map<String, dynamic> json) {
  return CatResponse((json['cats'] as List)
      ?.map((e) => e == null ? null : Cat.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$CatResponseToJson(CatResponse instance) =>
    <String, dynamic>{'cats': instance.cats};
