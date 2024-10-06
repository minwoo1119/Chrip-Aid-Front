import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/member/model/entity/orphanage_user_entity.dart';
import 'package:chrip_aid/member/model/entity/user_detail_entity.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../member/model/entity/orphanage_member_entity.dart';
import '../../../orphanage/model/entity/orphanage_detail_entity.dart';
import '../../../orphanage/model/entity/orphanage_entity.dart';
import '../dto/admin_orphanage_user_update_request_dto.dart';
import '../dto/admin_user_update_request_dto.dart';

part 'admin_accountmanager_repository.g.dart';

final adminAccountManagementRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AdminAccountManagementRepository(dio);
});

@RestApi()
abstract class AdminAccountManagementRepository {
  factory AdminAccountManagementRepository(Dio dio, {String? baseUrl}) = _AdminAccountManagementRepository;

  // 사용자 정보 추가
  @POST('/admin/users')
  @Headers({'accessToken': 'true'})
  Future<void> createUser(@Body() AdminUserCreateRequestDTO dto);

  // 등록된 사용자 정보 전체 조회
  @GET('/admin/users')
  @Headers({'accessToken': 'true'})
  Future<List<UserDetailEntity>> getAllUsers();

  // 사용자 정보 ID 검색
  @GET('/admin/users/id')
  @Headers({'accessToken': 'true'})
  Future<UserDetailEntity> getUserById(@Query('id') String id);

  // 사용자 정보 닉네임 검색
  @GET('/admin/users/nickname')
  @Headers({'accessToken': 'true'})
  Future<UserDetailEntity> getUserByNickname(@Query('nickname') String nickname);

  // 사용자 정보 수정
  @PATCH('/admin/users/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> updateUser(@Path('id') String id, @Body() UserUpdateRequestDto dto);

  // 사용자 정보 삭제
  @DELETE('/admin/users/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteUser(@Path('id') String id);

  // 보육원 사용자 정보 추가
  @POST('/admin/orphanage-users')
  @Headers({'accessToken': 'true'})
  Future<void> createOrphanageUser(@Body() AdminUserCreateRequestDTO dto);

  // 등록된 보육원 사용자 정보 전체 조회
  @GET('/admin/orphanage-users')
  @Headers({'accessToken': 'true'})
  Future<List<OrphanageUserEntity>> getAllOrphanageUsers();

  // 보육원 사용자 정보 ID 검색
  @GET('/admin/orphanage-users/id')
  @Headers({'accessToken': 'true'})
  Future<OrphanageDetailEntity> getOrphanageUserById(@Query('id') String id);

  // 보육원 사용자 이름 검색
  @GET('/admin/orphanage-users/name')
  @Headers({'accessToken': 'true'})
  Future<OrphanageDetailEntity> getOrphanageUserByName(@Query('name') String name);

  // 보육원 사용자 정보 수정
  @PATCH('/admin/orphanage-users/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> updateOrphanageUser(@Path('id') String id, @Body() OrphanageUserUpdateRequestDto dto);

  // 보육원 사용자 정보 삭제
  @DELETE('/admin/orphanage-users/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteOrphanageUser(@Path('id') String id);
}

class AdminUserCreateRequestDTO {
}
