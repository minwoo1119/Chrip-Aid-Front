import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/post/model/entity/post_request_entity.dart';
import 'package:chrip_aid/post/model/entity/post_reservation_entity.dart';
import 'package:chrip_aid/post/model/entity/post_thanks_entity.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';


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
  Future<List<PostReservationEntity>> getReservationPosts();

  // 특정 방문 예약글 조회
  @GET('/admin/board/reservation/{id}')
  @Headers({'accessToken': 'true'})
  Future<PostReservationEntity> getReservationPostsById(@Path("id") int postId);

  // 방문 예약글 삭제
  @DELETE('/admin/board/reservation/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteReservationPost(@Path("id") int postId);

  // 물품 요청글 조회
  @GET('/admin/board/request')
  @Headers({'accessToken': 'true'})
  Future<List<PostRequestEntity>> getRequestPosts();

  // 특정 물품 요청글 조회
  @GET('/admin/board/request/{id}')
  @Headers({'accessToken': 'true'})
  Future<PostRequestEntity> getRequestPostsById(@Path("id") int postId);

  // 물품 요청글 삭제
  @DELETE('/admin/board/request/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteRequestPost(@Path("id") int postId);

  // 기부 감사글 조회
  @GET('/posts')
  @Headers({'accessToken': 'true'})
  Future<List<PostThanksEntity>> getThanksPosts();

  // 특정 기부 감사글 조회
  @GET('/admin/board/post/{id}')
  @Headers({'accessToken': 'true'})
  Future<PostThanksEntity> getThanksPostsById(@Path("id") int postId);

  // 기부 감사글 삭제
  @DELETE('/admin/board/post/{id}')
  @Headers({'accessToken': 'true'})
  Future<void> deleteThanksPost(@Path("id") int postId);
}
