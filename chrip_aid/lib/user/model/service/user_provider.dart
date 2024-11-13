import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/user/model/dto/user_dto.dart';

// UserNotifier 클래스: 로그인 후 사용자 정보를 상태로 저장
class UserNotifier extends StateNotifier<UserDto?> {
  UserNotifier() : super(null);

  void setUserInfo(UserDto userInfo) {
    state = userInfo;
  }

  void clearUserInfo() {
    state = null;
  }
}

// Provider 선언
final userProvider = StateNotifierProvider<UserNotifier, UserDto?>((ref) {
  return UserNotifier();
});
