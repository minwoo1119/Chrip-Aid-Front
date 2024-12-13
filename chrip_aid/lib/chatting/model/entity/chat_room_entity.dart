import 'package:chrip_aid/chatting/model/entity/chatting_orphanage_user_entity.dart';
import 'package:chrip_aid/chatting/model/entity/chatting_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room_entity.g.dart';

@JsonSerializable()
class ChatRoomEntity {
  final String chatRoomId;
  final ChattingUserEntity user; // 사용자 정보
  final ChattingOrphanageUserEntity orphanageUser; // 보육원 사용자 정보

  ChatRoomEntity({
    required this.chatRoomId,
    required this.user,
    required this.orphanageUser,
  });

  // JSON 직렬화 및 역직렬화 메소드 추가
  factory ChatRoomEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomEntityToJson(this);
}


