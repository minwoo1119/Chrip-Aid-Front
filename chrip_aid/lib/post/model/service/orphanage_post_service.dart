import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:chrip_aid/post/model/entity/tag_entity.dart';
import 'package:chrip_aid/post/model/entity/write_post_request_dto.dart';
import 'package:chrip_aid/post/model/repository/orphanage_post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanagePostServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanagePostRepositoryProvider);
  return OrphanagePostService(repository);
});

class OrphanagePostService {
  final OrphanagePostRepository repository;

  OrphanagePostService(this.repository);

  Future<ResponseEntity<List<GetPostsEntity>>> getOrphanagePosts() async {
    try {
      List<GetPostsEntity> data = await repository.getOrphanagePosts();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: "인증글 목록을 가져오는데 실패하였습니다.");
    }
  }

  Future<ResponseEntity<List<TagEntity>>> getTags() async {
    try {
      List<TagEntity> data = await repository.getTags();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: "태그 목록을 가져오는데 실패하였습니다.");
    }
  }

  Future writePost(WritePostRequestDTO dto) async {
    try {
      await repository.writePost(dto);
      getOrphanagePosts();
    } catch (e) {
      return ResponseEntity.error(message: "인증글을 작성하는데 실패하였습니다.");
    }
  }
}
