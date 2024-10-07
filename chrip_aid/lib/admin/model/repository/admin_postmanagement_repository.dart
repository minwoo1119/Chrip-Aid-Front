import 'package:chrip_aid/admin/model/dto/thanks_post_dto.dart';
import 'package:chrip_aid/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../dto/item_request_post_dto.dart';
import '../dto/visit_request_post_dto.dart';


part 'admin_postmanagement_repository.g.dart';

final adminPostManagementRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AdminPostManagementRepository(dio);
});

@RestApi()
abstract class AdminPostManagementRepository {
  factory AdminPostManagementRepository(Dio dio, {String? baseUrl}) = _AdminPostManagementRepository;

  // 방문 예약글 조회
  @GET('/admin/board/reservation')
  @Headers({'accessToken': 'true'})
  Future<List<VisitRequestPostDto>> getReservationPosts();

  // 특정 방문 예약글 조회
  @GET('/admin/board/reservation/{id}')
  @Headers({'accessToken': 'true'})
  Future<VisitRequestPostDto> getReservationPostsById(@Path("id") int postId);

  // 방문 예약글 삭제
  @DELETE('/admin/board/reservation/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteReservationPost(@Path("id") int postId);

  // 물품 요청글 조회
  @GET('/admin/board/request')
  @Headers({'accessToken': 'true'})
  Future<List<ItemRequestPostDto>> getRequestPosts();

  // 특정 물품 요청글 조회
  @GET('/admin/board/request/{id}')
  @Headers({'accessToken': 'true'})
  Future<ItemRequestPostDto> getRequestPostsById(@Path("id") int postId);

  // 물품 요청글 삭제
  @DELETE('/admin/board/request/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteRequestPost(@Path("id") int postId);

  // 기부 감사글 조회
  @GET('/posts')
  @Headers({'accessToken': 'true'})
  Future<List<ThanksPostDto>> getThanksPosts();

  // 특정 기부 감사글 조회
  @GET('/admin/board/post/{id}')
  @Headers({'accessToken': 'true'})
  Future<ThanksPostDto> getThanksPostsById(@Path("id") int postId);

  // 기부 감사글 삭제
  @DELETE('/admin/board/post/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteThanksPost(@Path("id") int postId);
}
