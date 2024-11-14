// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orphanage_member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrphanageMemberEntity _$OrphanageMemberEntityFromJson(
        Map<String, dynamic> json) =>
    OrphanageMemberEntity(
      orphanageId: (json['orphanage_id'] as num).toInt(),
      orphanageName: json['orphanage_name'] as String,
      address: json['address'] as String,
      homepageLink: json['homepage_link'] as String,
      phoneNumber: json['phone_number'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$OrphanageMemberEntityToJson(
        OrphanageMemberEntity instance) =>
    <String, dynamic>{
      'orphanage_id': instance.orphanageId,
      'orphanage_name': instance.orphanageName,
      'address': instance.address,
      'homepage_link': instance.homepageLink,
      'phone_number': instance.phoneNumber,
      'description': instance.description,
      'photo': instance.photo,
    };
