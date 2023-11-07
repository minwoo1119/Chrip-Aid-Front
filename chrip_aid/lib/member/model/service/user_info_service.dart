import 'package:chrip_aid/auth/model/type/region/gyeonggi.dart';
import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:chrip_aid/member/model/dto/edit_user_info_request_dto.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';
import 'package:chrip_aid/member/model/repository/user_info_repository.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberInfoServiceProvider =
    StateNotifierProvider<MemberInfoService, MemberInfoState>((ref) {
  final userInfoRepository = ref.watch(userInfoRepositoryProvider);
  return MemberInfoService(userInfoRepository);
});

class MemberInfoService extends StateNotifier<MemberInfoState> {
  final MemberInfoRepository userInfoRepository;

  MemberInfoService(this.userInfoRepository) : super(MemberInfoStateNone()) {
    getMemberInfo();
  }

  Future editMemberInfo(EditUserInfoRequestDto user) async {
    state = MemberInfoStateLoading();
    try {
      await userInfoRepository.editUserInfo(user);
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
    return state = MemberInfoStateSuccess(
      UserEntity(
        email: "email",
        name: "name",
        nickName: "nickName",
        age: 20,
        sex: Sex.man,
        region: Gyeonggi.pajusi,
        phone: "01000000000",
        profileUrl: "",
      ),
    );
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
