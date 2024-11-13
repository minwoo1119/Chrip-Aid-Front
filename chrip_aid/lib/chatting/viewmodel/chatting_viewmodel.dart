import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/user/model/dto/user_dto.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';

final chattingViewModelProvider = Provider((ref) {
  final authService = ref.read(authServiceProvider);
  final localStorage = ref.read(localStorageProvider);
  return ChattingViewModel(authService, localStorage);
});

class ChattingViewModel {
  final AuthService authService;
  final LocalStorage storage;

  ChattingViewModel(this.authService, this.storage);

  Future<String> getUserAuthority() async {
    return await storage.read(key: 'authority') ?? 'USER';
  }

  Future<UserDto> fetchUserInfo() async {
    return await authService.getUserDetailInfo();
  }
}
