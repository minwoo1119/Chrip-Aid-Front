import 'package:json_annotation/json_annotation.dart';

part 'user_edit_dto.g.dart';

@JsonSerializable()
class UserEditDto {
  final String name;
  final String email;
  final String? password; // 비밀번호는 선택적으로 변경될 수 있음
  final int age;
  final String sex;
  final String nickname;
  final String region;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'profile_photo')
  final String profilePhoto;
  final String role;

  UserEditDto({
    required this.name,
    required this.email,
    this.password,
    required this.age,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.role,
  });

  factory UserEditDto.fromJson(Map<String, dynamic> json) =>
      _$UserEditDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserEditDtoToJson(this);
}
