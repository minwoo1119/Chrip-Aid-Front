import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/post/component/custom_post_box.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/post/viewmodel/user_posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPostScreen extends ConsumerWidget implements PostScreen {
  const UserPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(userPostsViewModelProvider)..getInfo();
    return DetailPageLayout(
      appBarBackgroundColor: CustomColor.backgroundMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      title: "인증글",
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
