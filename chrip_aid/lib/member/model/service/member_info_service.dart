import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/member/model/dto/edit_member_info_request_dto.dart';
import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:chrip_aid/member/model/repository/member_info_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberInfoServiceProvider = Provider((ref) {
  final userInfoRepository = ref.watch(memberInfoRepositoryProvider);
  return MemberInfoService(userInfoRepository);
});

class MemberInfoService {
  final MemberInfoRepository userInfoRepository;

  MemberInfoService(this.userInfoRepository);

  Future<ResponseEntity<MemberEntity>> editMemberInfo(EditMemberInfoRequestDto member) async {
    try {
      await userInfoRepository.editUserInfo(member);
      return await getMemberInfo();
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity<MemberEntity>> getMemberInfo() async {
    try {
      final data = await userInfoRepository.getUserInfo();
      return ResponseEntity.success(entity: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "사용자 정보를 가져올 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }
}
