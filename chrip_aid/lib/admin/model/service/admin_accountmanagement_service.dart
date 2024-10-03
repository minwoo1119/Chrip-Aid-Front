import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/entity/user_detail_entity.dart';
import 'package:chrip_aid/member/model/entity/user_member_entity.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../orphanage/model/entity/orphanage_entity.dart';
import '../repository/admin_accountmanager_repository.dart';

final adminAccountManagementServiceProvider = Provider((ref) {
  final repository = ref.read(adminAccountManagementRepositoryProvider);
  return AdminAccountManagementService(repository, ref);
});

class AdminAccountManagementService {
  final Ref ref;
  late final AdminAccountManagementRepository repository;

  AdminAccountManagementService(this.repository, this.ref);

  Future<ResponseEntity<List<OrphanageEntity>>> getOrphanageList() async {
    try {
      MemberEntity? member = MemberInfoState().value;
      if (member is! OrphanageMemberEntity) {
        return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
      }

      List<OrphanageEntity> data = await repository.getAllOrphanageUsers();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<UserDetailEntity>> getUserList() async {
    try {
      print('Requesting user list from repository...');
      UserDetailEntity data = await repository.getAllUsers();
      print('Received user list: $data');
      return ResponseEntity.success(entity: data);
    } catch (e) {
      print('Error while requesting user list: $e');
      return ResponseEntity.error(message: e.toString());
    }
  }


  Future<ResponseEntity<UserDetailEntity>> getUserById(String userId) async {
    try {
      UserDetailEntity data = await repository.getUserById(userId);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<UserDetailEntity>> getUserByNickname(String nickname) async {
    try {
      UserDetailEntity data = await repository.getUserByNickname(nickname);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<OrphanageEntity>>> getOrphanageUserList() async {
    try {
      List<OrphanageEntity> data = await repository.getAllOrphanageUsers();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<OrphanageDetailEntity>> getOrphanageUserById(String orphanageUserId) async {
    try {
      OrphanageDetailEntity data = await repository.getOrphanageUserById(orphanageUserId);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<OrphanageDetailEntity>> getOrphanageUserByName(String orphanageUserName) async {
    try {
      OrphanageDetailEntity data = await repository.getOrphanageUserByName(orphanageUserName);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 추가된 함수들: 사용자 및 보육원 사용자 세부 정보를 가져오는 함수

  Future<ResponseEntity<UserDetailEntity>> getUserDetailInfo(String userId) async {
    try {
      UserDetailEntity data = await repository.getUserById(userId);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<OrphanageDetailEntity>> getOrphanageUserDetailInfo(String orphanageUserId) async {
    try {
      OrphanageDetailEntity data = await repository.getOrphanageUserById(orphanageUserId);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
