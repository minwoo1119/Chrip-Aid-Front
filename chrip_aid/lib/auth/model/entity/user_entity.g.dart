// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      sex: UserEntity._sexFromString(json['sex'] as String),
      region: json['region'] as String,
      phone: json['phone_number'] as String,
      profileUrl: json['profile_photo'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'age': instance.age,
      'sex': UserEntity._sexToString(instance.sex),
      'region': instance.region,
      'phone_number': instance.phone,
      'profile_photo': instance.profileUrl,
    };
