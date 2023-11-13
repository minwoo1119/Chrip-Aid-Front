import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/common/utils/aws_utils.dart';
import 'package:chrip_aid/post/component/tag_list.dart';
import 'package:chrip_aid/post/model/entity/tag_entity.dart';
import 'package:chrip_aid/post/model/entity/write_post_product_dto.dart';
import 'package:chrip_aid/post/model/entity/write_post_request_dto.dart';
import 'package:chrip_aid/post/model/service/orphanage_post_service.dart';
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
  TagListController tagListController = TagListController();

  OrphanageEditPostsViewModel(this.ref) {
    ref
        .read(orphanagePostServiceProvider.notifier)
        .getTags()
        .then((value) => tagListController.setTags(value));
  }

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

  void post(BuildContext context) async {
    List<String> urls = [];
    for (var element in images) {
      String? url = await uploadFileToS3(element, AwsS3Dir.post);
      if(url != null) urls.add(url);
    }
    ref
        .read(orphanagePostServiceProvider.notifier)
        .writePost(WritePostRequestDTO(
      title: titleController.text,
      content: contentController.text,
      photos: urls.join(", "),
      products: tagListController.selectedList.map((e) =>
          WritePostProductDTO(productName: e.name)).toList(),
    ));
    context.pop();
  }
}
