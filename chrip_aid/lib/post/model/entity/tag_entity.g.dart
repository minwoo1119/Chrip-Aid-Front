// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagEntity _$TagEntityFromJson(Map<String, dynamic> json) => TagEntity(
      json['product_name'] as String,
      isSelected: json['is_selected'] as bool? ?? false,
    );

Map<String, dynamic> _$TagEntityToJson(TagEntity instance) => <String, dynamic>{
      'product_name': instance.name,
      'is_selected': instance.isSelected,
    };
