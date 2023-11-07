// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orphanage_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrphanageDetailEntity _$OrphanageDetailEntityFromJson(
        Map<String, dynamic> json) =>
    OrphanageDetailEntity(
      orphanageName: json['orphanage_name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as String,
      photo: json['photo'] as String,
      homepageLink: json['homepage_link'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      requests: (json['requests'] as List<dynamic>)
          .map((e) => RequestItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrphanageDetailEntityToJson(
        OrphanageDetailEntity instance) =>
    <String, dynamic>{
      'orphanage_name': instance.orphanageName,
      'address': instance.address,
      'phone_number': instance.phoneNumber,
      'photo': instance.photo,
      'homepage_link': instance.homepageLink,
      'name': instance.name,
      'description': instance.description,
      'requests': instance.requests,
    };
