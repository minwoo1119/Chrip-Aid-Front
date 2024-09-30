import 'package:json_annotation/json_annotation.dart';

part 'admin_orphanage_user_update_request_dto.g.dart';

@JsonSerializable()
class OrphanageUserUpdateRequestDto {
  final String? name;
  final String? email;
  final String? password;

  OrphanageUserUpdateRequestDto({
    this.name,
    this.email,
    this.password,
  });

  factory OrphanageUserUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrphanageUserUpdateRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrphanageUserUpdateRequestDtoToJson(this);
}
