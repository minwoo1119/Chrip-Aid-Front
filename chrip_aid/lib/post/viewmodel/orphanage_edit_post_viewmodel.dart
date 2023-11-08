import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/post/component/tag_list.dart';
import 'package:chrip_aid/post/model/entity/tag_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

final orphanageEditPostsViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageEditPostsViewModel(ref));

class OrphanageEditPostsViewModel extends ChangeNotifier {
  Ref ref;

  final ImagePicker _imagePicker = ImagePicker();
  final List<File> images = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  SwiperController swiperController = SwiperController();
  TagListController tagListController = TagListController([
    TagEntity("초코파이"),
    TagEntity("초코파이"),
    TagEntity("초코파이"),
    TagEntity("초코파이"),
  ]);

  OrphanageEditPostsViewModel(this.ref);

  void removeImage() async {
    images.removeAt(swiperController.index);
    notifyListeners();
  }

  void pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    images.add(File(image.path.toString()));
    notifyListeners();
  }

  void post(BuildContext context) {
    context.pop();
  }
}
