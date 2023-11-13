// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_post_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WritePostRequestDTO _$WritePostRequestDTOFromJson(Map<String, dynamic> json) =>
    WritePostRequestDTO(
      title: json['title'] as String,
      content: json['content'] as String,
      photos: json['photos'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => WritePostProductDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WritePostRequestDTOToJson(
        WritePostRequestDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'photos': instance.photos,
      'products': instance.products,
    };
