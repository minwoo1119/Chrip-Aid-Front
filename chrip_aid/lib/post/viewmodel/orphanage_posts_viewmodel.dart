import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:chrip_aid/post/model/service/orphanage_post_service.dart';
import 'package:chrip_aid/post/model/state/post_state.dart';
import 'package:chrip_aid/post/view/orphanage_edit_post_screen.dart';
import 'package:chrip_aid/post/view/post_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanagePostsViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanagePostsViewModel(ref));

class OrphanagePostsViewModel extends ChangeNotifier {
  Ref ref;

  late final OrphanagePostService _postService;
  PostListState get postListState => _postService.postListState;

  List<GetPostsEntity>? get entity => postListState.value;

  OrphanagePostsViewModel(this.ref) {
    _postService = ref.read(orphanagePostServiceProvider);
    postListState.addListener(notifyListeners);
    getInfo();
  }

  void getInfo() => _postService.getOrphanagePosts();

  void navigateToEditScreen(BuildContext context) {
    context.pushNamed(OrphanageEditPostScreen.routeName);
  }

  void navigateToDetailScreen(BuildContext context, GetPostsEntity entity) {
    context.pushNamed(PostDetailScreen.routeName, extra: entity);
  }
}
