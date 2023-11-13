import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:chrip_aid/post/model/entity/tag_entity.dart';
import 'package:chrip_aid/post/model/entity/write_post_request_dto.dart';
import 'package:chrip_aid/post/model/repository/orphanage_post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanagePostServiceProvider =
    StateNotifierProvider<OrphanagePostService, OrphanageState>((ref) =>
        OrphanagePostService(ref.watch(orphanagePostRepositoryProvider)));

class OrphanagePostService extends StateNotifier<OrphanageState> {
  final OrphanagePostRepository repository;

  OrphanagePostService(this.repository) : super(OrphanagePostStateLoading());

  Future getOrphanagePosts() async {
    try {
      state = OrphanagePostStateLoading();
      List<GetPostsEntity> data = await repository.getOrphanagePosts();
      state = OrphanagePostStateSuccess(data);
    } catch (e) {
      state = OrphanagePostStateError(e.toString());
    }
  }

  Future<List<TagEntity>> getTags() async {
    List<TagEntity> data = await repository.getTags();
    return data;
  }

  Future writePost(WritePostRequestDTO dto) async {
    try {
      state = OrphanagePostStateLoading();
      await repository.writePost(dto);
      getOrphanagePosts();
    } catch (e) {
      print(e);
      state = OrphanagePostStateError(e.toString());
    }
  }
}
