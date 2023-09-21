import 'package:chrip_aid/auth/dto/signup_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_signup_request_dto.g.dart';

@JsonSerializable()
class UserSignupRequestDto implements SignupRequestDto {
  @override
  String name;
  @override
  String email;
  @override
  String password;
  String sex;
  String nickname;
  String region;
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  @JsonKey(name: 'profile_photo')
  String profilePhoto;

  UserSignupRequestDto({
    required this.name,
    required this.email,
    required this.password,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
  });

  @override
  Map<String, dynamic> toJson() => _$UserSignupRequestDtoToJson(this);

  factory UserSignupRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserSignupRequestDtoFromJson(json);
}
