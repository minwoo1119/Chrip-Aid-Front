import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/styles/text_styles.dart';
import 'package:chrip_aid/orphanage/component/custom_product_box.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_edit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageManagementScreen extends ConsumerWidget {
  static String get routeName => "orphanageManage";

  const OrphanageManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanageEditViewModelProvider);
    return DetailPageLayout(
      appBarBackgroundColor: Colors.transparent,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          // TODO : add function (navigate to edit orphanage info page)
        onPressed: () {},
          icon: const Icon(Icons.edit, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: viewModel.state is SuccessState
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Image.asset(
                          viewModel.entity.photo,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingMiddleSize,
                            vertical: kPaddingMiniSize),
                        child: Column(
                          children: [
                            CustomTextField(
                              text: viewModel.entity.orphanageName,
                              textSize: kTextMediumSize,
                            ),
                            CustomTextField(
                              iconData: Icons.location_on,
                              text: viewModel.entity.address,
                            ),
                            CustomTextField(
                              iconData: Icons.phone,
                              text: viewModel.entity.phoneNumber,
                            ),
                            CustomTextField(
                              iconData: Icons.person,
                              text: viewModel.entity.name,
                            ),
                            CustomTextField(
                              iconData: Icons.monitor,
                              text: viewModel.entity.homepageLink,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 5.0,
                    color: CustomColor.disabledColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kPaddingMiddleSize,
                      right: kPaddingMiddleSize,
                      top: kPaddingMiniSize,
                      bottom: kPaddingSmallSize,
                    ),
                    child: Column(
                      children: [
                        const CustomTextField(
                          iconData: Icons.description,
                          text: "소개글",
                        ),
                        Text(
                          viewModel.entity.description,
                          style: kTextContentStyleSmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5.0,
                    color: CustomColor.disabledColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: kPaddingMiddleSize),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kPaddingMiddleSize,
                      right: kPaddingSmallSize,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "요청 물품 목록",
                          style: kTextContentStyleSmall,
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                          // TODO : add product info function
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            size: kIconSmallSize,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingSmallSize,
                          ),
                          constraints: const BoxConstraints(),
                          splashRadius: kIconSmallSize,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: kPaddingMiniSize),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: viewModel.entity.requests.length,
                      itemBuilder: (context, index) {
                        final item = viewModel.entity.requests[index];
                        // TODO : change component (edit product info box)
                        return CustomProductBox(
                          requiredId: item.requestId,
                          photo: item.productPhoto,
                          name: item.productName,
                          description: item.message,
                          price: item.price,
                          requestCount: item.requestCount,
                          supportCount: item.supportCount,
                          progress: item.supportCount / item.requestCount,
                        );
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
