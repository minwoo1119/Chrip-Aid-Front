import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/post/component/custom_post_box.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/post/viewmodel/orphanage_posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanagePostScreen extends ConsumerWidget implements PostScreen {
  const OrphanagePostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanagePostsViewModelProvider);
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
      child: viewModel.state is SuccessState
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.entity.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.entity[index];
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
