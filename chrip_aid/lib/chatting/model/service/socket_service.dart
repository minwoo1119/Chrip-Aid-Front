import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService{
  late IO.Socket socket;

  void connect() {
    // 서버 URL 설정
    socket = IO.io('ws://3.34.17.191:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // 서버에 연결
    socket.connect();

    // 연결 상태 확인
    socket.onConnect((_) {
      print('Connected to the chat server');
    });

    // 연결 해제
    socket.onDisconnect((_) {
      print('Disconnected from the chat server');
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

  // 이전 대화 불러오기
  void getRoomMessages(String roomId, Function(List<dynamic>) callback) {
    socket.on('roomMessages', (data) {
      print('Previous messages: $data');
      callback(data);
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