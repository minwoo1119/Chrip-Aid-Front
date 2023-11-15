import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:chrip_aid/post/model/entity/tag_entity.dart';
import 'package:chrip_aid/post/model/entity/write_post_request_dto.dart';
import 'package:chrip_aid/post/model/repository/orphanage_post_repository.dart';
import 'package:chrip_aid/post/model/state/post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanagePostServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanagePostRepositoryProvider);
  return OrphanagePostService(repository);
});

class OrphanagePostService {
  final OrphanagePostRepository repository;

  final postListState = PostListState();

  OrphanagePostService(this.repository);

  Future getOrphanagePosts() async {
    try {
      postListState.loading();
      List<GetPostsEntity> data = await repository.getOrphanagePosts();
      postListState.success(value:  data);
    } catch (e) {
      postListState.error(message: e.toString());
    }
  }

  Future<List<TagEntity>> getTags() async {
    List<TagEntity> data = await repository.getTags();
    return data;
  }

  Future writePost(WritePostRequestDTO dto) async {
    try {
      postListState.loading();
      await repository.writePost(dto);
      getOrphanagePosts();
    } catch (e) {
      postListState.error(message: e.toString());
    }
  }
}
