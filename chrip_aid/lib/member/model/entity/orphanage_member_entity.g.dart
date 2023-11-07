// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orphanage_member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrphanageMemberEntity _$OrphanageMemberEntityFromJson(
        Map<String, dynamic> json) =>
    OrphanageMemberEntity(
      email: json['email'] as String,
      name: json['name'] as String,
      orphanage: OrphanageDetailEntity.fromJson(
          json['orphanage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrphanageMemberEntityToJson(
        OrphanageMemberEntity instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'orphanage': instance.orphanage,
    };
