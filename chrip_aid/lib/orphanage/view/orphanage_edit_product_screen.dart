import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/styles/text_styles.dart';
import 'package:chrip_aid/orphanage/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_edit_product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

class OrphanageEditProductScreen extends ConsumerWidget {
  static String get routeName => 'editProduct';
  final AddOrphanageProductRequestDTO? entity;

  const OrphanageEditProductScreen({Key? key, this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanageEditProductViewModelProvider);
    return DefaultLayout(
      title: "물품 요청글 작성",
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
                      labelText: "물품명",
                      decorationStyle: kTextSubContentStyleSmall,
                      textStyle: kTextContentStyleMedium.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.only(
                        bottom: kPaddingMiniSize,
                      ),
                    ),
                    const SizedBox(height: kPaddingMiddleSize),
                    CustomTextFormField(
                      textController: viewModel.contentController,
                      fieldColor: CustomColor.backGroundSubColor,
                      backgroundColor: CustomColor.backGroundSubColor,
                      borderRadius: BorderRadius.zero,
                      inputBorder: const UnderlineInputBorder(),
                      labelText: "메시지",
                      minLine: 1,
                      maxLine: 2,
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
                        vertical: kPaddingMiniSize,
                      ).copyWith(bottom: kPaddingSmallSize),
                      child: Row(
                        children: [
                          const Text("이미지", style: kTextSubContentStyleSmall),
                          const Expanded(child: SizedBox()),
                          if (viewModel.images.isNotEmpty)
                            IconButton(
                              onPressed: viewModel.removeImage,
                              icon: const Icon(
                                Icons.delete,
                                size: kIconSmallSize,
                              ),
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
                                color: CustomColor.contentSubColor,
                              ),
                              splashRadius: 75,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            )
                          : _DesignedSwiper(
                              itemCount: viewModel.images.length,
                              itemBuilder: (_, index) => InkWell(
                                onTap: () => showDialog(
                                  useRootNavigator: true,
                                  context: context,
                                  builder: (context) => DefaultLayout(
                                    extendBodyBehindAppBar: true,
                                    appbarColor: Colors.transparent,
                                    leading: IconButton(
                                      onPressed: context.pop,
                                      icon: const Icon(Icons.close),
                                      color: CustomColor.textReverseColor,
                                      splashRadius: kIconSmallSize,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    actions: [
                                      IconButton(
                                        onPressed: () {
                                          viewModel.removeImage();
                                          context.pop();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: kIconSmallSize,
                                        ),
                                        color: CustomColor.textReverseColor,
                                        splashRadius: kIconSmallSize,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      const SizedBox(width: kPaddingMiddleSize),
                                    ],
                                    title: "",
                                    child: PhotoView(
                                      imageProvider: FileImage(
                                        viewModel.images[index],
                                      ),
                                    ),
                                  ),
                                ),
                                child: Image.file(
                                  viewModel.images[index],
                                  fit: BoxFit.fitWidth,
                                ),
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

class _DesignedSwiper extends Swiper {
  static const Color _color = CustomColor.textReverseColor;
  static const Color _disableColor = Color(0x55ffffff);

  const _DesignedSwiper({
    required super.itemCount,
    super.itemBuilder,
    super.controller,
  }) : super(
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              color: _disableColor,
              activeColor: _color,
            ),
          ),
          loop: false,
        );
}
