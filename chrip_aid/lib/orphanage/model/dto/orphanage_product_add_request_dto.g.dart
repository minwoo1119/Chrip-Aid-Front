// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orphanage_product_add_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrphanageProductAddRequestDTO _$OrphanageProductAddRequestDTOFromJson(
        Map<String, dynamic> json) =>
    OrphanageProductAddRequestDTO(
      productName: json['product_name'] as String,
      count: json['count'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$OrphanageProductAddRequestDTOToJson(
        OrphanageProductAddRequestDTO instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'count': instance.count,
      'message': instance.message,
    };
