import 'package:chrip_aid/post/model/entity/get_posts_entity.dart';
import 'package:chrip_aid/post/model/service/orphanage_post_service.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userPostsViewModelProvider =
ChangeNotifierProvider((ref) => UserPostsViewModel(ref));

class UserPostsViewModel extends ChangeNotifier {
  Ref ref;

  late OrphanageState state;

  List<GetPostsEntity> get entity =>
      (state as OrphanagePostStateSuccess).data;

  UserPostsViewModel(this.ref) {
    state = ref.read(orphanagePostServiceProvider);
    ref.listen(orphanagePostServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }
}
