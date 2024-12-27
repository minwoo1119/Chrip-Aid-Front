import 'package:chrip_aid/chatting/model/dto/chat_message_dto.dart';
import 'package:chrip_aid/chatting/model/dto/chat_room_dto.dart';
import 'package:chrip_aid/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'chatting_repository.g.dart';

final chattingRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ChattingRepository(dio);
});

@RestApi()
abstract class ChattingRepository {
  factory ChattingRepository(Dio dio, {String? baseUrl}) = _ChattingRepository;

  // 모든 채팅방 조회
  @GET('/chats/rooms')
  @Headers({'accessToken': 'true'})
  Future<List<ChatRoomDto>> getAllChatRooms();

  // 모든 메시지 조회
  @GET('/chats/messages')
  @Headers({'accessToken': 'true'})
  Future<List<ChatMessageDto>> getAllChatMessages();

  // 일반 사용자 ID 기반 모든 채팅방 조회
  @GET('/chats/rooms/user')
  @Headers({'accessToken': 'true'})
  Future<List<ChatRoomDto>> getChatRoomByUserId();

  // 보육원 사용자 ID 기반 모든 채팅방 조회
  @GET('/chats/rooms/orphanage-user/{orphanageUserId}')
  @Headers({'accessToken': 'true'})
  Future<List<ChatRoomDto>> getChatRoomByOrphanageId(@Path('orphanageUserId') String orphanageUserId);

  // 특정 채팅방 내 모든 메시지 조회
  @GET('/chats/messages/room/{chatRoomId}')
  @Headers({'accessToken': 'true'})
  Future<List<ChatMessageDto>> getAllMessageThisRoom(@Path('chatRoomId') String chatRoomId);
}
