import 'package:json_annotation/json_annotation.dart';

part 'chat_message_entity.g.dart';

@JsonSerializable()
class ChatMessageEntity {
  final String messageId;
  final String sender;
  final String type; // 메시지 타입 (예: USER, ORPHANAGE 등)
  final String content; // 메시지 내용
  final bool isRead; // 읽음 여부
  final String createdAt; // 생성 일시

  ChatMessageEntity({
    required this.messageId,
    required this.sender,
    required this.type,
    required this.content,
    required this.isRead,
    required this.createdAt,
  });

  // JSON 직렬화 및 역직렬화 메소드 추가
  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageEntityToJson(this);
}
