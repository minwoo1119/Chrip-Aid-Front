
import 'package:chrip_aid/chatting/model/entity/chatting_orphanage_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chatting_orphanage_user_dto.g.dart';

@JsonSerializable()
class ChattingOrphanageUserDto {
  @JsonKey(name: 'orphanage_user_id') // 서버에서 orphanage_user_id를 orphanageUserId로 매핑
  final String orphanageUserId;

  final String name;
  final String email;

  ChattingOrphanageUserDto({
    required this.orphanageUserId,
    required this.name,
    required this.email,
  });

  factory ChattingOrphanageUserDto.fromJson(Map<String, dynamic> json) =>
      _$ChattingOrphanageUserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ChattingOrphanageUserDtoToJson(this);

  ChattingOrphanageUserEntity toEntity() {
    return ChattingOrphanageUserEntity(
      orphanageUserId: orphanageUserId,
      name: name,
      email: email,
    );
  }
}
