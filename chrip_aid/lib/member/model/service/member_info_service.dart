import 'package:chrip_aid/auth/model/type/region/gyeonggi.dart';
import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:chrip_aid/member/model/dto/edit_member_info_request_dto.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';
import 'package:chrip_aid/member/model/repository/user_info_repository.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/request_item_entity.dart';
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
    return state = MemberInfoStateSuccess(
/*      UserEntity(
        email: "email",
        name: "name",
        nickName: "nickName",
        age: 20,
        sex: Sex.man,
        region: Gyeonggi.pajusi,
        phone: "01000000000",
        profileUrl: "",
      )*/
      OrphanageMemberEntity(
        email: 'email',
        name: '윤하경',
        orphanage: OrphanageDetailEntity(
          orphanageName: '파주 보육원',
          address: '경기도 파주시 법원읍 술이홀로907번길 139',
          phoneNumber: '031)958-7176',
          photo: 'assets/image/pajukids_house.jpg',
          homepageLink: 'www.pajukids.com',
          name: '윤하경',
          description:
          '사시사철 웃음가득, 기쁨 가득 파주키즈 동산에 방문하신 여러분을 환영합니다! 아이들을 사랑하는 마음들이 모아져 여러분들과 함께 기쁨의 공간을 채우고 나누게 되어 매우 기쁘게 생각합니다.',
          requests: [
            RequestItemEntity(
              productPhoto: 'assets/image/choco_pie.jpg',
              productName: "초코파이",
              message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
              price: 8630,
              requestCount: 30,
              supportCount: 21,
              requestId: 1,
            ),
            RequestItemEntity(
              productPhoto: 'assets/image/choco_pie.jpg',
              productName: "초코파이",
              message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
              price: 8630,
              requestCount: 30,
              supportCount: 21,
              requestId: 2,
            ),
            RequestItemEntity(
              productPhoto: 'assets/image/choco_pie.jpg',
              productName: "초코파이",
              message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
              price: 8630,
              requestCount: 30,
              supportCount: 21,
              requestId: 3,
            ),
            RequestItemEntity(
              productPhoto: 'assets/image/choco_pie.jpg',
              productName: "초코파이",
              message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
              price: 8630,
              requestCount: 30,
              supportCount: 21,
              requestId: 4,
            ),
            RequestItemEntity(
              productPhoto: 'assets/image/choco_pie.jpg',
              productName: "초코파이",
              message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
              price: 8630,
              requestCount: 30,
              supportCount: 21,
              requestId: 4,
            ),
            RequestItemEntity(
              productPhoto: 'assets/image/choco_pie.jpg',
              productName: "초코파이",
              message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
              price: 8630,
              requestCount: 30,
              supportCount: 21,
              requestId: 4,
            ),
            RequestItemEntity(
              productPhoto: 'assets/image/choco_pie.jpg',
              productName: "초코파이",
              message: "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
              price: 8630,
              requestCount: 30,
              supportCount: 21,
              requestId: 4,
            ),
          ],
        ),
      )
      ,
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
