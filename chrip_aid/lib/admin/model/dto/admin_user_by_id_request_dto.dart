import 'package:json_annotation/json_annotation.dart';

part 'admin_user_by_id_request_dto.g.dart';

@JsonSerializable()
class AdminUserByIdRequestDto {
  final String name;
  final String email;
  final int age;
  final String sex;
  final String nickname;
  final String region;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'profile_photo')
  final String profilePhoto;
  final String role;

  AdminUserByIdRequestDto({
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
  factory AdminUserByIdRequestDto.fromJson(Map<String, dynamic> json) => _$AdminUserByIdRequestDtoFromJson(json);

  // 객체를 JSON으로 변환하기 위한 method
  Map<String, dynamic> toJson() => _$AdminUserByIdRequestDtoToJson(this);
}
