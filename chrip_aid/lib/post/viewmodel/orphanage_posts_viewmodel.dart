import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:chrip_aid/post/model/service/orphanage_post_service.dart';
import 'package:chrip_aid/post/model/state/post_state.dart';
import 'package:chrip_aid/post/view/orphanage_edit_post_screen.dart';
import 'package:chrip_aid/post/view/post_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanagePostsViewModelProvider =
    Provider((ref) => OrphanagePostsViewModel(ref));

class OrphanagePostsViewModel {
  Ref ref;

  late final OrphanagePostService _postService;
  PostListState postListState = PostListState();

  OrphanagePostsViewModel(this.ref) {
    _postService = ref.read(orphanagePostServiceProvider);
  }

  void getInfo() => postListState.withResponse(_postService.getOrphanagePosts());

  void navigateToEditScreen(BuildContext context) {
    context.pushNamed(OrphanageEditPostScreen.routeName).then((value) => getInfo());
  }

  void navigateToDetailScreen(BuildContext context, GetPostsEntity entity) {
    context.pushNamed(PostDetailScreen.routeName, extra: entity);
  }
}
