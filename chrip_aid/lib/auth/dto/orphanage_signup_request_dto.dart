import 'package:chrip_aid/auth/dto/signup_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orphanage_signup_request_dto.g.dart';

@JsonSerializable()
class OrphanageSignupRequestDto implements SignupRequestDto {
  @override
  String email;

  @override
  String name;

  @override
  String password;
  @JsonKey(name: 'orphanage_name')
  String orphanageName;

  OrphanageSignupRequestDto({
    required this.name,
    required this.email,
    required this.password,
    required this.orphanageName,
  });

  @override
  Map<String, dynamic> toJson() => _$OrphanageSignupRequestDtoToJson(this);

  factory OrphanageSignupRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrphanageSignupRequestDtoFromJson(json);
}
