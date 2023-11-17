import 'package:chrip_aid/common/component/custom_image_picker.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/styles/text_styles.dart';
import 'package:chrip_aid/post/component/tag_list.dart';
import 'package:chrip_aid/post/viewmodel/orphanage_edit_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageEditPostScreen extends ConsumerWidget {
  static String get routeName => 'editPost';

  const OrphanageEditPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(orphanageEditPostsViewModelProvider)..getInfo();
    return DefaultLayout(
      title: "인증글 작성",
      titleStyle: kTextContentStyleMedium,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingSmallSize),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      textController: viewModel.titleController,
                      fieldColor: CustomColor.backGroundSubColor,
                      backgroundColor: CustomColor.backGroundSubColor,
                      borderRadius: BorderRadius.zero,
                      inputBorder: const UnderlineInputBorder(),
                      labelText: "제목",
                      decorationStyle: kTextSubContentStyleSmall,
                      textStyle: kTextContentStyleMedium.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.only(
                        bottom: kPaddingMiniSize,
                      ),
                    ),
                    const SizedBox(height: kPaddingMiddleSize),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingSmallSize,
                      ),
                      child: TagList(controller: viewModel.tagListController),
                    ),
                    const SizedBox(height: kPaddingMiddleSize),
                    CustomTextFormField(
                      keyboardType: TextInputType.multiline,
                      textController: viewModel.contentController,
                      fieldColor: CustomColor.backGroundSubColor,
                      backgroundColor: CustomColor.backGroundSubColor,
                      borderRadius: BorderRadius.zero,
                      inputBorder: const OutlineInputBorder(),
                      labelText: "본문",
                      decorationStyle: kTextSubContentStyleSmall,
                      minLine: 12,
                      textStyle: kTextContentStyleMedium.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.all(kPaddingSmallSize),
                    ),
                    const SizedBox(height: kPaddingMiddleSize),
                    CustomImagePicker(controller: viewModel.imageController),
                  ],
                ),
              ),
            ),
            const SizedBox(height: kPaddingMiddleSize),
            CustomOutlinedButton(
              onPressed: () => viewModel.post(context),
              text: 'POST',
              textStyle: kTextReverseStyleMiddle,
            ),
            const SizedBox(height: kPaddingMiddleSize),
          ],
        ),
      ),
    );
  }
}