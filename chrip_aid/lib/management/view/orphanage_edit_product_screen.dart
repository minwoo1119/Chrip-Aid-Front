import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/styles/text_styles.dart';
import 'package:chrip_aid/management/component/custom_basket_product_box_2.dart';
import 'package:chrip_aid/management/model/dto/add_orphanage_product_request_dto.dart';
import 'package:chrip_aid/management/viewmodel/orphanage_edit_product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingSmallSize,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("물품", style: kTextSubContentStyleSmall),
                          const SizedBox(height: kPaddingSmallSize),
                          if (viewModel.product != null)
                            CustomBasketProductBox2(
                              productName: viewModel.product!.productName,
                              count: viewModel.productCount,
                              price: viewModel.product!.price,
                              photo: viewModel.product!.image,
                              onCountUpdate: viewModel.onCountUpdate,
                              onDelete: viewModel.onProductDelete,
                            )
                          else
                            InkWell(
                              onTap: () => viewModel.openProductModal(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 90,
                                width: double.infinity,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.search, size: kIconMiddleSize),
                                    SizedBox(width: kPaddingSmallSize),
                                    Text("Search Product"),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kPaddingMiddleSize),
                    CustomTextFormField(
                      textController: viewModel.messageController,
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
