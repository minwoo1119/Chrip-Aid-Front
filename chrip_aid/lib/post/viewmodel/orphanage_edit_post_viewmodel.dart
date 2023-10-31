import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageEditPostsViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageEditPostsViewModel(ref));

class OrphanageEditPostsViewModel extends ChangeNotifier {
  Ref ref;

  OrphanageEditPostsViewModel(this.ref);
}
