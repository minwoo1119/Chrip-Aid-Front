import 'package:chrip_aid/chatting/model/dto/chatting_orphanage_user_dto.dart';
import 'package:chrip_aid/chatting/model/dto/chatting_user_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import '../entity/chat_room_entity.dart';

part 'chat_room_dto.g.dart';

@JsonSerializable()
class ChatRoomDto {
  @JsonKey(name: 'chat_room_id') // 서버 응답의 chat_room_id와 매핑
  final String chatRoomId;

  @JsonKey(name: 'user') // 중첩된 객체도 같은 방식으로 처리
  final ChattingUserDto user;

  @JsonKey(name: 'orphanage_user')
  final ChattingOrphanageUserDto orphanageUser;

  ChatRoomDto({
    required this.chatRoomId,
    required this.user,
    required this.orphanageUser,
  });

  // JSON 직렬화 및 역직렬화 메소드
  factory ChatRoomDto.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomDtoToJson(this);

  // 엔티티 변환 메소드
  ChatRoomEntity toEntity() {
    return ChatRoomEntity(
      chatRoomId: chatRoomId,
      user: user.toEntity(),
      orphanageUser: orphanageUser.toEntity(),
    );
  }
}

