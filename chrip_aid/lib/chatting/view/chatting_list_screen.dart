import 'package:chrip_aid/common/component/custom_chats_list.dart';
import 'package:chrip_aid/user/model/service/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/sizes.dart';
import '../../orphanage/layout/detail_page_layout.dart';
import '../model/entity/chat_room_entity.dart';
import '../model/service/chatting_list_service.dart';

class ChatRoomListNotifier extends StateNotifier<List<ChatRoomEntity>?> {
  final ChattingListService chatService;

  ChatRoomListNotifier(this.chatService) : super(null) {
    fetchChatRooms();
  }

  Future<void> fetchChatRooms() async {
    final rooms = await chatService.getAllChatRooms();
    if (rooms.entity != null && rooms.entity!.isNotEmpty) {
      final filteredRooms = await chatService.getChatRoomByUserId();
      state = filteredRooms.entity;
    } else {
      state = []; // 채팅방이 없을 경우 빈 리스트 설정
    }
  }
}

final chatRoomsProvider = StateNotifierProvider<ChatRoomListNotifier, List<ChatRoomEntity>?>(
      (ref) {
    final chatService = ref.read(chattingListServiceProvider);
    return ChatRoomListNotifier(chatService);
  },
);

class ChattingListScreen extends ConsumerWidget {
  static String get routeName => 'chatting';

  const ChattingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRooms = ref.watch(chatRoomsProvider);

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: 'Chats',
      titleColor: CustomColor.textReverseColor,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Expanded(
            child: Builder(
              builder: (context) {
                if (chatRooms == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (chatRooms.isEmpty) {
                  return const Center(child: Text('채팅방이 없습니다.'));
                } else {
                  return ListView.builder(
                    itemCount: chatRooms.length,
                    itemBuilder: (context, index) {
                      final room = chatRooms[index];
                      return CustomChatsList(
                          chat_room_id: room.chatRoomId,
                          name: room.orphanageUser.name
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToChatRoom(BuildContext context, ChatRoomEntity room) {
    context.push(
      '/chatting/${room.chatRoomId}',
      extra: {'targetId': room.user.userId},
    );
  }
}
