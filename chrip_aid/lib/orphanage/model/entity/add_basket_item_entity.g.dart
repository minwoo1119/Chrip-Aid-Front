// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_basket_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBasketItemEntity _$AddBasketItemEntityFromJson(Map<String, dynamic> json) =>
    AddBasketItemEntity(
      requestId: json['count'] as int,
      count: json['request_id'] as int,
    );

Map<String, dynamic> _$AddBasketItemEntityToJson(
        AddBasketItemEntity instance) =>
    <String, dynamic>{
      'count': instance.requestId,
      'request_id': instance.count,
    };
