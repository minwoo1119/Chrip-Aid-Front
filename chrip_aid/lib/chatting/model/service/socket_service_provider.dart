import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'socket_service.dart';

final socketServiceProvider = Provider<SocketService>((ref) {
  final socketService = SocketService();
  socketService.connect(); // Provider 생성 시 서버에 연결
  ref.onDispose(() => socketService.disconnect()); // Provider가 소멸될 때 연결 해제
  return socketService;
});
