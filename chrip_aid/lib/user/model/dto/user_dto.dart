import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "age")
  int age;

  @JsonKey(name: "sex")
  String sex;

  @JsonKey(name: "nickname")
  String nickname;

  @JsonKey(name: "region")
  String region;

  @JsonKey(name: "phone_number")
  String phoneNumber;

  @JsonKey(name: "profile_photo")
  String profilePhoto;

  @JsonKey(name: "role")
  String role;

  UserDto({
    required this.name,
    required this.email,
    required this.age,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.role,
  });

  // JSON 변환 함수들
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
