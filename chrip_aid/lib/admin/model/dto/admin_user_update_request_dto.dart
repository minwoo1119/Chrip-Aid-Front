import 'package:json_annotation/json_annotation.dart';

part 'admin_user_update_request_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UserUpdateRequestDto {
  final String? name;
  final String? email;
  final String? password;
  final int? age;
  final String? sex;
  final String? nickname;
  final String? region;
  final String? phoneNumber;
  final String? profilePhoto;
  final String? role;

  UserUpdateRequestDto({
    this.name,
    this.email,
    this.password,
    this.age,
    this.sex,
    this.nickname,
    this.region,
    this.phoneNumber,
    this.profilePhoto,
    this.role,
  });

  // JSON으로 변환하는 메서드 (자동 생성된 메서드를 사용)
  factory UserUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestDtoToJson(this);
}
