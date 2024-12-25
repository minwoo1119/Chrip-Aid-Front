import 'package:chrip_aid/chatting/model/dto/chat_message_dto.dart';
import 'package:chrip_aid/chatting/model/dto/chat_room_dto.dart';
import 'package:chrip_aid/chatting/model/repository/chatting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/chat_message_entity.dart';
import '../entity/chat_room_entity.dart';
import '../../../common/entity/response_entity.dart';

final chattingListServiceProvider = Provider((ref) {
  final repository = ref.read(chattingRepositoryProvider);
  return ChattingListService(repository);
});

class ChattingListService {
  final ChattingRepository repository;

  ChattingListService(this.repository);

  // 모든 채팅방 조회
  Future<ResponseEntity<List<ChatRoomEntity>>> getAllChatRooms() async {
    try {
      print('Requesting all chat rooms from repository...');
      List<ChatRoomDto> chatRoomDtos = await repository.getAllChatRooms();
      return ResponseEntity.success(entity: chatRoomDtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      print('Error while requesting all chat rooms: $e');
      return ResponseEntity.error(message: 'Failed to load chat rooms');
    }
  }

  // 모든 메시지 조회
  Future<ResponseEntity<List<ChatMessageEntity>>> getAllChatMessages() async {
    try {
      print('Requesting all chat messages from repository...');
      List<ChatMessageDto> chatMessageDtos = await repository.getAllChatMessages();
      return ResponseEntity.success(entity: chatMessageDtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      print('Error while requesting all chat messages: $e');
      return ResponseEntity.error(message: 'Failed to load chat messages');
    }
  }

  // 사용자 ID 기반 채팅방 조회
  Future<ResponseEntity<List<ChatRoomEntity>>> getChatRoomByUserId() async {
    try {
      print('Requesting chat rooms by user ID from repository...');
      List<ChatRoomDto> chatRoomDtos = await repository.getChatRoomByUserId();
      return ResponseEntity.success(entity: chatRoomDtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      print('Error while requesting chat rooms by user ID: $e');
      return ResponseEntity.error(message: 'Failed to load chat rooms by user ID');
    }
  }

  // 보육원 사용자 ID 기반 채팅방 조회
  Future<ResponseEntity<List<ChatRoomEntity>>> getChatRoomByOrphanageId(String orphanageUserId) async {
    try {
      print('Requesting chat rooms by orphanage user ID from repository...');
      List<ChatRoomDto> chatRoomDtos = await repository.getChatRoomByOrphanageId(orphanageUserId);
      return ResponseEntity.success(entity: chatRoomDtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      print('Error while requesting chat rooms by orphanage user ID: $e');
      return ResponseEntity.error(message: 'Failed to load chat rooms by orphanage user ID');
    }
  }

  // 특정 채팅방의 모든 메시지 조회
  Future<ResponseEntity<List<ChatMessageEntity>>> getAllMessagesThisRoom(String chatRoomId) async {
    try {
      print('Requesting all messages for chat room from repository...');
      List<ChatMessageDto> chatMessageDtos = await repository.getAllMessageThisRoom(chatRoomId);
      return ResponseEntity.success(entity: chatMessageDtos.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      print('Error while requesting messages for this room: $e');
      return ResponseEntity.error(message: 'Failed to load messages for this room');
    }
  }
}
