import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/common/component/custom_image_picker.dart';
import 'package:chrip_aid/common/utils/aws_utils.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/post/component/tag_list.dart';
import 'package:chrip_aid/post/model/entity/write_post_product_dto.dart';
import 'package:chrip_aid/post/model/entity/write_post_request_dto.dart';
import 'package:chrip_aid/post/model/service/orphanage_post_service.dart';
import 'package:chrip_aid/post/model/state/post_tag_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageEditPostsViewModelProvider =
    Provider((ref) => OrphanageEditPostsViewModel(ref));

class OrphanageEditPostsViewModel {
  Ref ref;

  late final OrphanagePostService _service;

  final PostTagListState postTagListState = PostTagListState();

  CustomImagePickerController imageController = CustomImagePickerController();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  SwiperController swiperController = SwiperController();
  TagListController tagListController = TagListController();

  OrphanageEditPostsViewModel(this.ref) {
    _service = ref.read(orphanagePostServiceProvider);
    postTagListState.addListener(() {
      if(!postTagListState.isSuccess) return;
      tagListController.setTags(postTagListState.value!);
    });
  }

  void getInfo() => postTagListState.withResponse(_service.getTags());

  void post(BuildContext context) async {
    List<String> urls = [];
    for (var element in imageController.value) {
      String? url = await uploadFileToS3(element, AwsS3Dir.post);
      if (url != null) urls.add(url);
    }
    _service.writePost(
      WritePostRequestDTO(
        title: titleController.text,
        content: contentController.text,
        photos: urls.join(", "),
        products: tagListController.selectedList
            .map((e) => WritePostProductDTO(productName: e.name))
            .toList(),
      ),
    );
    if (context.mounted) context.pop();
  }
}
