import 'package:chrip_aid/member/model/dto/edit_member_info_request_dto.dart';
import 'package:chrip_aid/member/model/repository/member_info_repository.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberInfoServiceProvider =
    StateNotifierProvider<MemberInfoService, MemberInfoState>((ref) {
  final userInfoRepository = ref.watch(memberInfoRepositoryProvider);
  return MemberInfoService(userInfoRepository);
});

class MemberInfoService extends StateNotifier<MemberInfoState> {
  final MemberInfoRepository userInfoRepository;

  MemberInfoService(this.userInfoRepository) : super(MemberInfoStateNone());

  Future editMemberInfo(EditMemberInfoRequestDto member) async {
    state = MemberInfoStateLoading();
    try {
      await userInfoRepository.editUserInfo(member);
      await getMemberInfo();
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return state = MemberInfoStateError(e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = MemberInfoStateError("서버와 연결할 수 없습니다.");
    } catch (e) {
      state = MemberInfoStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future getMemberInfo() async {
    try {
      final data = await userInfoRepository.getUserInfo();
      state = MemberInfoStateSuccess(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return state = MemberInfoStateError(e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = MemberInfoStateError("사용자 정보를 가져올 수 없습니다.");
    } catch (e) {
      state = MemberInfoStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
