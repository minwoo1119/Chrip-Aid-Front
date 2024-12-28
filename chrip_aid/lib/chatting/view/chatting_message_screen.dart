import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import '../model/service/socket_service.dart';

class ChattingMessageScreen extends StatefulWidget {
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

class _ChattingMessageScreenState extends State<ChattingMessageScreen> {
  final List<Map<String, dynamic>> _messages = [];
  late final SocketService _socketService;
  String userName = '';
  String userState = '';

  @override
  void initState() {
    super.initState();

    // SocketService 초기화
    _socketService = SocketService();
    _socketService.initializeSocket(widget.userId);

    print("Initializing ChattingMessageScreen");
    print("ChatRoomId: ${widget.chatRoomId}, TargetId: ${widget.targetId}");

    _initializeSocketListeners();
    _socketService.joinRoom(widget.chatRoomId);
    print("Joined room: ${widget.chatRoomId}");

    _initializeUserDetails();
  }

  Future<void> _initializeUserDetails() async {
    // 여기에 사용자 정보를 가져오는 로직을 추가하세요
    print("Fetching user details...");
    try {
      // 예제 데이터
      setState(() {
        userName = "User Name";
        userState = "User State";
      });
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  void _initializeSocketListeners() {
    print("Initializing socket listeners...");
    _socketService.onNewMessage((message) {
      print("New message received: $message");
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    print("Leaving room: ${widget.chatRoomId}");
    _socketService.leaveRoom(widget.chatRoomId);
    _socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: widget.targetId,
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSentByMe = message['sender'] == widget.userId;
                return _buildChatBubble(isSentByMe, message['content']);
              },
            ),
          ),
          _BottomInputField(
            chatRoomId: widget.chatRoomId,
            socketService: _socketService,
            userName: userName,
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

  const _BottomInputField({
    Key? key,
    required this.chatRoomId,
    required this.socketService,
    required this.userName,
  }) : super(key: key);

  @override
  State<_BottomInputField> createState() => _BottomInputFieldState();
}

class _BottomInputFieldState extends State<_BottomInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      final messageContent = _controller.text;
      print("Sending message: $messageContent");

      widget.socketService.sendMessage(
        widget.userName,
        "USER",
        widget.chatRoomId,
        messageContent,
      );

      setState(() {
        final newMessage = {'sender': widget.userName, 'content': messageContent};
        context.findAncestorStateOfType<_ChattingMessageScreenState>()?._messages.add(newMessage);
      });

      _controller.clear();
    } else {
      print("Message content is empty, nothing to send.");
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
                  hintText: 'Enter your message...',
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
