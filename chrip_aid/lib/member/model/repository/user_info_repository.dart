import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/member/model/dto/edit_user_info_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return UserInfoRepository(dio);
});

class UserInfoRepository {
  final Dio dio;

  UserInfoRepository(this.dio);

  Future editUserInfo(EditUserInfoRequestDto entity) async {

  }
}
