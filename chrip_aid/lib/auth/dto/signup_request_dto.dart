import 'package:json_annotation/json_annotation.dart';

part 'signup_request_dto.g.dart';

@JsonSerializable()
class SignupRequestDto{
  String name;
  String email;
  String password;

  SignupRequestDto({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SignupRequestDtoToJson(this);

  factory SignupRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestDtoFromJson(json);
}
