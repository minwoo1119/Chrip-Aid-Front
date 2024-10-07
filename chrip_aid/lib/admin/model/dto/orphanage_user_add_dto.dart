import 'package:json_annotation/json_annotation.dart';

part 'orphanage_user_add_dto.g.dart';

@JsonSerializable()
class OrphanageUserAddDto {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'orphanage_name')
  final String orphanageName;

  OrphanageUserAddDto({
    required this.name,
    required this.email,
    required this.password,
    required this.orphanageName,
  });

  factory OrphanageUserAddDto.fromJson(Map<String, dynamic> json) =>
      _$OrphanageUserAddDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrphanageUserAddDtoToJson(this);
}
