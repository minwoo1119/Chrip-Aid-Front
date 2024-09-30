import 'package:json_annotation/json_annotation.dart';

part 'admin_all_user_request_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String name;
  final String email;
  final int age;
  final String sex;
  final String nickname;
  final String region;
  final String phoneNumber;
  final String profilePhoto;
  final String role;

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

  // JSON에서 객체를 생성하기 위한 factory method
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  // 객체를 JSON으로 변환하기 위한 method
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
