import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/member/model/dto/edit_member_info_request_dto.dart';
import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:chrip_aid/member/model/entity/orphanage_user_entity.dart';
import 'package:chrip_aid/member/model/repository/member_info_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    // Flutter Secure Storage 초기화
    final secureStorage = FlutterSecureStorage();

    try {
      final data = await userInfoRepository.getUserInfo();

      // orphanageId 추출 및 저장
      final orphanageId = data.orphanageId?.orphanageId;
      if (orphanageId != null) {
        // orphanageId를 보안 스토리지에 저장
        await secureStorage.write(key: 'orphanageId', value: orphanageId.toString());
        print('Orphanage ID saved: $orphanageId');
      } else {
        print('No orphanage ID available to save.');
      }

      return ResponseEntity.success(entity: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "사용자 정보를 가져올 수 없습니다.");
    } catch (e) {
      print(e);
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }
}