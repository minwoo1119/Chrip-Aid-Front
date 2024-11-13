import 'package:chrip_aid/chatting/model/entity/chat_message_entity.dart';
import 'package:chrip_aid/chatting/model/entity/chat_room_entity.dart';
import 'package:chrip_aid/chatting/model/service/chatting_list_service.dart';
import 'package:chrip_aid/chatting/model/state/chatting_message_state.dart';
import 'package:chrip_aid/chatting/model/state/chatting_room_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/value_state/state/value_state.dart';
import '../../common/entity/response_entity.dart';  // 수정됨

final chattingListViewModelProvider = Provider((ref) => ChattingListViewModel(ref));

class ChattingListViewModel {
  final Ref ref;
  late final ChattingListService _chattingService;

  // 상태 관리 객체
  ValueStateNotifier<List<ChatRoomEntity>> chatRoomState = ChattingRoomState();
  ValueStateNotifier<List<ChatMessageEntity>> chatMessageState = ChattingMessageState();

  // 캐시된 데이터 리스트
  List<ChatRoomEntity>? _cachedChatRoomList;
  List<ChatMessageEntity>? _cachedChatMessageList;

  ChattingListViewModel(this.ref) {
    _chattingService = ref.read(chattingListServiceProvider);
  }

  // 모든 채팅방 가져오기
  Future<List<ChatRoomEntity>> getAllChatRooms() async {
    try {
      if (_cachedChatRoomList != null) {
        print('Returning cached chat room list');
        chatRoomState.success(value: _cachedChatRoomList!);
        return _cachedChatRoomList!;
      }

      chatRoomState.loading();
      final ResponseEntity<List<ChatRoomEntity>> response = await _chattingService.getAllChatRooms(); // 수정됨
      if (response.isSuccess) {
        final chatRoomList = response.entity!;
        print('Received data from service: $chatRoomList');
        chatRoomState.success(value: chatRoomList);
        _cachedChatRoomList = chatRoomList;
        return chatRoomList;
      } else {
        throw Exception(response.message ?? 'Unknown error');
      }
    } catch (e) {
      chatRoomState.error(message: e.toString());
      print('Exception occurred while loading chat rooms: $e');
      rethrow;
    }
  }

  // 특정 사용자 ID로 채팅방 가져오기
  Future<List<ChatRoomEntity>> getChatRoomByUserId(String userId) async {
    try {
      chatRoomState.loading();
      final ResponseEntity<List<ChatRoomEntity>> response = await _chattingService.getChatRoomByUserId(userId); // 수정됨
      if (response.isSuccess) {
        final chatRoomList = response.entity!;
        print('Received data from service for userId $userId: $chatRoomList');
        chatRoomState.success(value: chatRoomList);
        return chatRoomList;
      } else {
        throw Exception(response.message ?? 'Unknown error');
      }
    } catch (e) {
      chatRoomState.error(message: e.toString());
      print('Exception occurred while loading chat rooms by user ID: $e');
      rethrow;
    }
  }

  // 특정 보육원 사용자 ID로 채팅방 가져오기
  Future<List<ChatRoomEntity>> getChatRoomByOrphanageId(String orphanageUserId) async {
    try {
      chatRoomState.loading();
      final ResponseEntity<List<ChatRoomEntity>> response = await _chattingService.getChatRoomByOrphanageId(orphanageUserId); // 수정됨
      if (response.isSuccess) {
        final chatRoomList = response.entity!;
        print('Received data from service for orphanageUserId $orphanageUserId: $chatRoomList');
        chatRoomState.success(value: chatRoomList);
        return chatRoomList;
      } else {
        throw Exception(response.message ?? 'Unknown error');
      }
    } catch (e) {
      chatRoomState.error(message: e.toString());
      print('Exception occurred while loading chat rooms by orphanage ID: $e');
      rethrow;
    }
  }

  // 모든 메시지 가져오기
  Future<List<ChatMessageEntity>> getAllChatMessages() async {
    try {
      if (_cachedChatMessageList != null) {
        print('Returning cached chat message list');
        chatMessageState.success(value: _cachedChatMessageList!);
        return _cachedChatMessageList!;
      }

      chatMessageState.loading();
      final ResponseEntity<List<ChatMessageEntity>> response = await _chattingService.getAllChatMessages(); // 수정됨
      if (response.isSuccess) {
        final chatMessageList = response.entity!;
        print('Received data from service: $chatMessageList');
        chatMessageState.success(value: chatMessageList);
        _cachedChatMessageList = chatMessageList;
        return chatMessageList;
      } else {
        throw Exception(response.message ?? 'Unknown error');
      }
    } catch (e) {
      chatMessageState.error(message: e.toString());
      print('Exception occurred while loading chat messages: $e');
      rethrow;
    }
  }

  // 특정 채팅방의 모든 메시지 가져오기
  Future<List<ChatMessageEntity>> getAllMessagesThisRoom(String chatRoomId) async {
    try {
      chatMessageState.loading();
      final ResponseEntity<List<ChatMessageEntity>> response = await _chattingService.getAllMessagesThisRoom(chatRoomId); // 수정됨
      if (response.isSuccess) {
        final chatMessageList = response.entity!;
        print('Received messages for chat room $chatRoomId: $chatMessageList');
        chatMessageState.success(value: chatMessageList);
        return chatMessageList;
      } else {
        throw Exception(response.message ?? 'Unknown error');
      }
    } catch (e) {
      chatMessageState.error(message: e.toString());
      print('Exception occurred while loading messages for this room: $e');
      rethrow;
    }
  }
}
