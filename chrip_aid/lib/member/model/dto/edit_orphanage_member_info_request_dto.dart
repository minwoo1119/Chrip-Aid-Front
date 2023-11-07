import 'package:chrip_aid/member/model/dto/edit_member_info_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_orphanage_member_info_request_dto.g.dart';

@JsonSerializable()
class EditOrphanageMemberInfoRequestDto implements EditMemberInfoRequestDto {
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'password')
  final String password;

  EditOrphanageMemberInfoRequestDto({
    required this.name,
    required this.password
  });

  @override
  Map<String, dynamic> toJson() => _$EditOrphanageMemberInfoRequestDtoToJson(this);

  factory EditOrphanageMemberInfoRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EditOrphanageMemberInfoRequestDtoFromJson(json);
}
