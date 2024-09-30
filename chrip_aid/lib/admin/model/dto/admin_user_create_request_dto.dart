import 'package:json_annotation/json_annotation.dart';

part 'admin_user_create_request_dto.g.dart';

@JsonSerializable()
class UserCreateRequestDto {
  final String name;
  final String email;
  final String password;
  final int age;
  final String sex;
  final String nickname;
  final String region;
  final String phoneNumber;
  final String profilePhoto;
  final String role;

  UserCreateRequestDto({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.role,
  });

  // JSON 데이터를 Dart 객체로 변환하는 팩토리 메서드
  factory UserCreateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserCreateRequestDtoFromJson(json);

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$UserCreateRequestDtoToJson(this);
}
