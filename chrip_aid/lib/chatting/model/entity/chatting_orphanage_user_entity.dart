
import 'package:json_annotation/json_annotation.dart';

part 'chatting_orphanage_user_entity.g.dart';

@JsonSerializable()
class ChattingOrphanageUserEntity {
  final String orphanageUserId;
  final String name;
  final String email;

  ChattingOrphanageUserEntity({
    required this.orphanageUserId,
    required this.name,
    required this.email,
  });

  factory ChattingOrphanageUserEntity.fromJson(Map<String, dynamic> json) =>
      _$ChattingOrphanageUserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ChattingOrphanageUserEntityToJson(this);
}
