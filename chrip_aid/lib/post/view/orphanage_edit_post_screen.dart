import 'package:card_swiper/card_swiper.dart';
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
    final viewModel = ref.watch(orphanageEditPostsViewModelProvider);
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingSmallSize,
                        vertical: kPaddingMiniSize,
                      ).copyWith(bottom: kPaddingSmallSize),
                      child: Row(
                        children: [
                          const Text("이미지", style: kTextSubContentStyleSmall),
                          const Expanded(child: SizedBox()),
                          if (viewModel.images.isNotEmpty)
                            IconButton(
                              onPressed: viewModel.removeImage,
                              icon: const Icon(Icons.delete,
                                  size: kIconSmallSize),
                              splashRadius: kIconSmallSize,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          const SizedBox(width: kPaddingMiniSize),
                          IconButton(
                            onPressed: viewModel.pickImage,
                            icon: const Icon(Icons.add, size: kIconSmallSize),
                            splashRadius: kIconSmallSize,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: viewModel.images.isEmpty
                          ? BoxDecoration(border: Border.all())
                          : null,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: kPaddingSmallSize,
                      ),
                      height: 250,
                      child: viewModel.images.isEmpty
                          ? IconButton(
                              onPressed: viewModel.pickImage,
                              icon: const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 75,
                              ),
                              splashRadius: 75,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            )
                          : _DesignedSwiper(
                              itemCount: viewModel.images.length,
                              itemBuilder: (_, index) => Image.file(
                                viewModel.images[index],
                              ),
                              controller: viewModel.swiperController,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: kPaddingMiddleSize),
            CustomOutlinedButton(
              onPressed: () => viewModel.post(context),
              text: 'Post',
            ),
            const SizedBox(height: kPaddingMiddleSize),
          ],
        ),
      ),
    );
  }
}

class _DesignedSwiper extends Swiper {
  const _DesignedSwiper({
    required super.itemCount,
    super.itemBuilder,
    super.controller,
  }) : super(
          viewportFraction: 0.8,
          scale: 0.9,
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              color: Colors.grey,
              activeColor: Colors.black,
            ),
          ),
          control: const SwiperControl(color: Colors.black),
        );
}
