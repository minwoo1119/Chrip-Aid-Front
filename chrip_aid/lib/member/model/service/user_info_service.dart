import 'package:chrip_aid/member/model/dto/edit_user_info_request_dto.dart';
import 'package:chrip_aid/member/model/repository/user_info_repository.dart';
import 'package:chrip_aid/member/model/state/user_info_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoServiceProvider =
    StateNotifierProvider<UserInfoService, UserInfoState>((ref) {
  final userInfoRepository = ref.watch(userInfoRepositoryProvider);
  return UserInfoService(userInfoRepository);
});

class UserInfoService extends StateNotifier<UserInfoState> {
  final UserInfoRepository userInfoRepository;

  UserInfoService(this.userInfoRepository) : super(UserInfoStateNone());

  Future editUserInfo(EditUserInfoRequestDto user) async {
    state = UserInfoStateLoading();
    try {
      await userInfoRepository.editUserInfo(user);
      state = UserInfoStateSuccess(true);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return state = UserInfoStateError(e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = UserInfoStateError("서버와 연결할 수 없습니다.");
    } catch (e) {
      state = UserInfoStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
