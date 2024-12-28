import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService{
  late IO.Socket socket;

  void initializeSocket(String userId) {
    print('userId in initializeSocket : '+userId);
    Map<String, dynamic> headers = {
      'x-user-id': userId,
    };

    socket = IO.io(
      'ws://3.34.17.191:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])  // 웹소켓 사용 설정
          .disableAutoConnect()           // 자동 연결 비활성화 (필요 시)
          .setExtraHeaders(headers)       // 헤더 설정
          .build(),
    );

    // 소켓 연결
    socket.connect();

    socket.onConnect((_) {
      print('Connected to socket');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket');
    });

    socket.on('newMessage', (data) {
      print('Received message from server: $data');
    });
  }

  // 채팅방 생성
  void createRoom(String userId, String orphanageUserId) {
    socket.emit('createRoom', {
      'user_id': userId,
      'orphanage_user_id': orphanageUserId,
    });
    socket.on('roomCreated', (data) {
      print('Room created with code: ${data['roomCode']}');
    });
  }

  // 메시지 전송
  void sendMessage(String sender, String type, String joinRoom, String content) {
    socket.emit('sendMessage', {
      'sender': sender,
      'type': type,
      'join_room': joinRoom,
      'content': content,
    });
  }

  // 새로운 메시지 수신
  void onNewMessage(Function(dynamic) callback) {
    socket.on('newMessage', callback);
  }

  // 채팅방 입장
  void joinRoom(String roomId) {
    socket.emit('joinRoom', {
      'roomId': roomId,
    });
    socket.on('roomMessages', (data) {
      print('Joined room and received messages: $data');
    });
  }

  // 채팅방 퇴장
  void leaveRoom(String roomId) {
    socket.emit('leaveRoom', {
      'roomId': roomId,
    });
  }

  // 연결 해제
  void disconnect() {
    socket.disconnect();
  }

}