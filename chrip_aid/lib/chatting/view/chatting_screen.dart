import 'package:chrip_aid/chatting/model/entity/chat_room_entity.dart';
import 'package:chrip_aid/chatting/viewmodel/chatting_viewmodel.dart';
import 'package:chrip_aid/common/component/custom_chats_list.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ChattingScreen extends ConsumerStatefulWidget {
  static String get routeName => 'chatting';

  const ChattingScreen({Key? key}) : super(key: key);

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends ConsumerState<ChattingScreen> {
  List<ChatRoomEntity>? _cachedChatRooms;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  void _fetchInitialData() async {
    final viewModel = ref.read(chattingViewModelProvider);
    final chatRooms = await viewModel.getAllChatRooms();

    setState(() {
      _cachedChatRooms = chatRooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: 'Chats',
      titleColor: Colors.white,
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
                if (_cachedChatRooms == null) {
                  // 데이터가 로드되지 않았을 때 (로딩 중)
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (_cachedChatRooms!.isEmpty) {
                  // 데이터가 로드됐지만 채팅방이 없을 때
                  return const Center(
                    child: Text('채팅방이 없습니다.'),
                  );
                } else {
                  // 데이터가 로드되고 채팅방이 있을 때
                  return SingleChildScrollView(
                    child: Column(
                      children: _cachedChatRooms!.map((room) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: CustomChatsList(
                            chat_room_id: room.chatRoomId,
                            name: room.user.name,
                            last_chat: "마지막 채팅 미리보기",
                            onTap: () => _navigateToChatRoom(context, room),
                          ),
                        );
                      }).toList(),
                    ),
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
