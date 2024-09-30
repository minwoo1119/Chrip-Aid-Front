import 'package:json_annotation/json_annotation.dart';

part 'admin_orphanage_by_name_request_dto.g.dart';

@JsonSerializable()
class OrphanageUserNameRequestDto {
  final String name;

  OrphanageUserNameRequestDto({
    required this.name,
  });

  factory OrphanageUserNameRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrphanageUserNameRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrphanageUserNameRequestDtoToJson(this);
}
