import 'package:chrip_aid/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../dto/user_dto.dart';
import '../dto/user_update_dto.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio);
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String? baseUrl}) = _UserRepository;

  // GET 요청 - 사용자 정보 조회
  @GET('/members/users/info')
  Future<UserDto> getUserInfo(@Header("Authorization") String authorization);

  // PATCH 요청 - 사용자 정보 수정
  @PATCH('/members/users/info')
  Future<void> updateUserInfo(
      @Header("Authorization") String authorization,
      @Body() UserUpdateDto userUpdateDto);
}
