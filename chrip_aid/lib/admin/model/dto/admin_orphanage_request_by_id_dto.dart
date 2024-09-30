import 'package:json_annotation/json_annotation.dart';

part 'admin_orphanage_request_by_id_dto.g.dart';

@JsonSerializable()
class OrphanageUserRequestDto {
  final String name;
  final String email;
  final String password;
  @JsonKey(name: 'orphanage_name')
  final String orphanageName;

  OrphanageUserRequestDto({
    required this.name,
    required this.email,
    required this.password,
    required this.orphanageName,
  });

  // JSON 데이터를 Dart 객체로 변환하는 팩토리 메서드
  factory OrphanageUserRequestDto.fromJson(Map<String, dynamic> json) => _$OrphanageUserRequestDtoFromJson(json);

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$OrphanageUserRequestDtoToJson(this);
}
