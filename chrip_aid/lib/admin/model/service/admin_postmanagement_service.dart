import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/admin_postmanagement_repository.dart';


final adminPostManagementServiceProvider = Provider((ref) {
  final repository = ref.read(adminPostManagementRepositoryProvider);
  return AdminPostManagementService(repository, ref);
});

class AdminPostManagementService {
  final Ref ref;
  late final AdminPostManagementRepository repository;

  AdminPostManagementService(this.repository, this.ref);

  // 게시글 목록 조회
  Future<ResponseEntity<List<GetPostsEntity>>> getPostList() async {
    try {
      List<GetPostsEntity> data = await repository.getPosts();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 특정 게시글 조회
  Future<ResponseEntity<GetPostsEntity>> getPost(int postId) async {
    try {
      GetPostsEntity data = await repository.getPost(postId);
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 게시글 수정
  // Future<ResponseEntity> editPost(EditPostRequestDTO dto) async {
  //   try {
  //     await repository.editPost(dto);
  //     return ResponseEntity.success();
  //   } catch (e) {
  //     return ResponseEntity.error(message: e.toString());
  //   }
  // }

  // 게시글 삭제
  Future<ResponseEntity> deletePost(int postId) async {
    try {
      await repository.deletePost(postId);
      return ResponseEntity.success();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
