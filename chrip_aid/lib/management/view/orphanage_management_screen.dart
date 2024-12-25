import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/styles/text_styles.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/component/custom_product_box_2.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/management/viewmodel/orphanage_management_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageManagementScreen extends ConsumerWidget {
  static String get routeName => "orphanageManage";

  const OrphanageManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(orphanageManagementViewModelProvider)..getInfo();
    return DetailPageLayout(
      appBarBackgroundColor: Colors.transparent,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () => viewModel.navigateToEditOrphanageScreen(context),
          icon: const Icon(Icons.edit, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: ValueStateListener(
        state: viewModel.orphanageState,
        loadingBuilder: (_, __) =>
            const Center(child: CircularProgressIndicator()),
        successBuilder: (_, state) {
          if (state.value == null) {
            return const Center(child: Text('No data available'));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Image.network(
                        state.value?.photo ?? 'https://via.placeholder.com/150',
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingMiddleSize,
                        vertical: kPaddingMiniSize,
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            text: state.value!.orphanageName,
                            textSize: kTextMediumSize,
                          ),
                          CustomTextField(
                            iconData: Icons.location_on,
                            text: state.value!.address,
                          ),
                          CustomTextField(
                            iconData: Icons.phone,
                            text: state.value!.phoneNumber,
                          ),
                          CustomTextField(
                            iconData: Icons.person,
                            text: state.value!.name ?? '',
                          ),
                          CustomTextField(
                            iconData: Icons.monitor,
                            text: state.value!.homepageLink,
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
                        state.value!.description,
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
                        onPressed: () =>
                            viewModel.navigateToAddProductScreen(context),
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
                if (state.value!.requests != null)
                  ListView.builder(
                    itemCount: state.value!.requests!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = state.value!.requests![index];
                      return CustomProductBox2(
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
              ],
            ),
          );
        },
      ),
    );
  }
}
