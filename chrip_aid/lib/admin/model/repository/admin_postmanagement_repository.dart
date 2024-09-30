import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
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

  // 게시글 목록 조회
  @GET('/posts')
  Future<List<GetPostsEntity>> getPosts();

  // 특정 게시글 조회
  @GET('/posts/{id}')
  Future<GetPostsEntity> getPost(@Path("id") int postId);

  // 게시글 수정
  // @PATCH('/posts/{id}')
  // Future<void> editPost(@Path("id") int postId, @Body() EditPostRequestDTO dto);

  // 게시글 삭제
  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path("id") int postId);
}
