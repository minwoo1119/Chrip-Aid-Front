// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orphanage_signup_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrphanageSignupRequestDto _$OrphanageSignupRequestDtoFromJson(
        Map<String, dynamic> json) =>
    OrphanageSignupRequestDto(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      orphanageName: json['orphanage_name'] as String,
    );

Map<String, dynamic> _$OrphanageSignupRequestDtoToJson(
        OrphanageSignupRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'orphanage_name': instance.orphanageName,
    };
