import 'package:chrip_aid/member/model/dto/edit_member_info_request_dto.dart';
import 'package:chrip_aid/member/model/repository/member_info_repository.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberInfoServiceProvider = Provider((ref) {
  final userInfoRepository = ref.watch(memberInfoRepositoryProvider);
  return MemberInfoService(userInfoRepository);
});

class MemberInfoService {
  final MemberInfoRepository userInfoRepository;

  MemberInfoState memberInfoState = MemberInfoState();

  MemberInfoService(this.userInfoRepository);

  Future editMemberInfo(EditMemberInfoRequestDto member) async {
    memberInfoState.loading();
    try {
      await userInfoRepository.editUserInfo(member);
      await getMemberInfo();
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        memberInfoState.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      memberInfoState.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      memberInfoState.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future getMemberInfo() async {
    memberInfoState.loading();
    try {
      final data = await userInfoRepository.getUserInfo();
      memberInfoState.success(value: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        memberInfoState.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      memberInfoState.error(message: "사용자 정보를 가져올 수 없습니다.");
    } catch (e) {
      memberInfoState.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future logout() async {
    memberInfoState.none();
  }
}
