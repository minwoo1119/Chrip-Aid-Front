import 'package:json_annotation/json_annotation.dart';
import '../entity/chat_message_entity.dart';

part 'chat_message_dto.g.dart';

@JsonSerializable()
class ChatMessageDto {
  final String messageId;
  final String sender;
  final String type;
  final String content;
  final bool isRead;
  final String createdAt;

  ChatMessageDto({
    required this.messageId,
    required this.sender,
    required this.type,
    required this.content,
    required this.isRead,
    required this.createdAt,
  });

  // JSON 직렬화 및 역직렬화 메소드
  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageDtoToJson(this);

  // 엔티티 변환 메소드
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      messageId: messageId,
      sender: sender,
      type: type,
      content: content,
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}
