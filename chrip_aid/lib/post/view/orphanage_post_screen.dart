import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/post/component/custom_post_box.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/post/viewmodel/orphanage_posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanagePostScreen extends ConsumerWidget implements PostScreen {
  const OrphanagePostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(orphanagePostsViewModelProvider)..getInfo();
    return DetailPageLayout(
      appBarBackgroundColor: CustomColor.backgroundMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      title: "인증글",
      actions: [
        IconButton(
          onPressed: () => viewModel.navigateToEditScreen(context),
          icon: const Icon(
            Icons.post_add,
            size: kIconMiddleSize,
          ),
        ),
      ],
      child: ValueStateListener(
        state: viewModel.postListState,
        successBuilder: (_, state) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.value!.length,
                itemBuilder: (context, index) {
                  final item = state.value![index];
                  return InkWell(
                    onTap: () => viewModel.navigateToDetailScreen(
                      context,
                      item,
                    ),
                    child: CustomPostBox(
                      reviewId: item.reviewId,
                      title: item.title,
                      content: item.content,
                      photo: item.photo[0],
                      date: item.date,
                      name: item.name,
                      orphanageName: item.orphanageName,
                      productNames: item.productNames,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
