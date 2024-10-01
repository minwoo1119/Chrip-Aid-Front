import 'package:json_annotation/json_annotation.dart';

part 'user_update_dto.g.dart';

@JsonSerializable()
class UserUpdateDto {
  @JsonKey(name: "name")
  String name;

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

  UserUpdateDto({
    required this.name,
    required this.age,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
  });

  // JSON 변환 함수들
  Map<String, dynamic> toJson() => _$UserUpdateDtoToJson(this);

  factory UserUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateDtoFromJson(json);
}
