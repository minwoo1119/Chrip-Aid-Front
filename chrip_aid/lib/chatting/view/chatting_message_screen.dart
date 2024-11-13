import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/chatting/viewmodel/chatting_viewmodel.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import '../model/service/socket_service.dart';
import '../model/service/socket_service_provider.dart';

class ChattingMessageScreen extends ConsumerStatefulWidget {
  final String chatRoomId;
  final String targetId;
  final String userId;

  const ChattingMessageScreen({
    Key? key,
    required this.chatRoomId,
    required this.targetId,
    required this.userId,
  }) : super(key: key);

  @override
  _ChattingMessageScreenState createState() => _ChattingMessageScreenState();
}

class _ChattingMessageScreenState extends ConsumerState<ChattingMessageScreen> {
  final List<Map<String, dynamic>> _messages = [];
  late final SocketService _socketService;
  String userName = '';
  String userState = '';
  late final String chatRoomId;
  late final String targetId;

  @override
  void initState() {
    super.initState();
    chatRoomId = widget.chatRoomId;
    targetId = widget.targetId;
    _socketService = ref.read(socketServiceProvider);
    _initializeUserDetails();
    _initializeSocketListeners(_socketService);
    _socketService.joinRoom(chatRoomId);
  }


  Future<void> _initializeUserDetails() async {
    final viewModel = ref.read(chattingViewModelProvider);
    final userInfo = await viewModel.fetchUserInfo();
    final authority = await viewModel.getUserAuthority();

    print("Fetched userName: ${userInfo.name}");
    print("Fetched userState: $authority");

    setState(() {
      userName = userInfo.name;
      userState = authority;
    });
  }

  void _initializeSocketListeners(SocketService socketService) {
    socketService.getRoomMessages(chatRoomId, (data) {
      setState(() {
        _messages.clear();
        _messages.addAll(data as Iterable<Map<String, dynamic>>);
      });
    });

    socketService.onNewMessage((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    _socketService.leaveRoom(chatRoomId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: targetId,
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                bool isSentByMe = message['sender'] == targetId;
                return _buildChatBubble(isSentByMe, message['content']);
              },
            ),
          ),
          _BottomInputField(
            chatRoomId: chatRoomId,
            socketService: _socketService,
            userName: userName,
            userState: userState,
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(bool isSentByMe, String message) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: isSentByMe ? CustomColor.itemMainColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _BottomInputField extends StatefulWidget {
  final String chatRoomId;
  final SocketService socketService;
  final String userName;
  final String userState;

  const _BottomInputField({
    Key? key,
    required this.chatRoomId,
    required this.socketService,
    required this.userName,
    required this.userState,
  }) : super(key: key);

  @override
  State<_BottomInputField> createState() => _BottomInputFieldState();
}

class _BottomInputFieldState extends State<_BottomInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      final messageContent = _controller.text;

      widget.socketService.sendMessage(
        widget.userName,
        widget.userState,
        widget.chatRoomId,
        messageContent,
      );

      setState(() {
        final newMessage = {'sender': widget.userName, 'content': messageContent};
        context.findAncestorStateOfType<_ChattingMessageScreenState>()?._messages.add(newMessage);
      });

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '메시지를 입력하세요...',
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blueAccent),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
