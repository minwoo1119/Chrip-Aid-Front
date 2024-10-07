import 'package:json_annotation/json_annotation.dart';

part 'orphanage_user_edit_dto.g.dart';

@JsonSerializable()
class OrphanageUserEditDto {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  OrphanageUserEditDto({
    required this.name,
    required this.email,
    required this.password,
  });

  factory OrphanageUserEditDto.fromJson(Map<String, dynamic> json) =>
      _$OrphanageUserEditDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrphanageUserEditDtoToJson(this);
}
