// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_orphanage_product_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOrphanageProductRequestDTO _$AddOrphanageProductRequestDTOFromJson(
        Map<String, dynamic> json) =>
    AddOrphanageProductRequestDTO(
      title: json['title'],
      count: (json['count'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$AddOrphanageProductRequestDTOToJson(
        AddOrphanageProductRequestDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'count': instance.count,
      'message': instance.message,
    };
