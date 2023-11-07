// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestItemEntity _$RequestItemEntityFromJson(Map<String, dynamic> json) =>
    RequestItemEntity(
      requestId: json['request_id'] as int,
      productName: json['product_name'] as String,
      price: json['price'] as int,
      requestCount: json['request_count'] as int,
      supportCount: json['support_count'] as int,
      message: json['message'] as String,
      productPhoto: json['product_photo'] as String,
    );

Map<String, dynamic> _$RequestItemEntityToJson(RequestItemEntity instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'product_name': instance.productName,
      'price': instance.price,
      'request_count': instance.requestCount,
      'support_count': instance.supportCount,
      'message': instance.message,
      'product_photo': instance.productPhoto,
    };
