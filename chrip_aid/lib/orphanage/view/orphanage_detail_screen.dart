import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/custom_product_box.dart';
import 'package:chrip_aid/orphanage/component/orphanage_text_form.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphange_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:chrip_aid/orphanage/const/tabs.dart';

class OrphanageDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'detailPage';

  const OrphanageDetailScreen({super.key});

  @override
  ConsumerState<OrphanageDetailScreen> createState() => _OrphanageDetailPageState();
}

class _OrphanageDetailPageState extends ConsumerState<OrphanageDetailScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  IconData fabIcon = Icons.shopping_cart;
  Color tabColor = Colors.white;
  Color tabTextColor = Colors.black;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: TABS.length, vsync: this);
    tabController.addListener(() {
      setState(() {
        fabIcon = tabController.index == 0
            ? Icons.shopping_cart
            : Icons.edit_document;
        tabColor = tabController.index == 0 ? Colors.white : CustomColor.mainColor;
        tabTextColor = tabController.index == 0 ? Colors.black : Colors.white;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(orphanageDetailViewModelProvider);
    final tabs = [0, 1];
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
        },
        child: DetailPageLayout(
          floatingActionButton: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              foregroundColor: CustomColor.mainColor,
              backgroundColor: Colors.white,
              shape: const CircleBorder(
                side: BorderSide(color: CustomColor.mainColor, width: 2.0),
              ),
              onPressed: () =>
                  viewModel.postOrGoBasket(tabController.index, context),
              child: Icon(
                fabIcon,
                size: kIconLargeSize,
              ),
            ),
          ),
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
                                iconData: Icons.description, text: "소개글"),
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
                      DefaultTabController(
                        length: tabs.length,
                        child: Column(
                          children: [
                            TabBar(
                              controller: tabController,
                              indicatorColor: CustomColor.mainColor,
                              unselectedLabelColor: Colors.black,
                              labelColor: tabTextColor,
                              labelStyle: kTextMainStyleMedium,
                              indicator: BoxDecoration(
                                color: tabColor,
                              ),
                              tabs: tabs
                                  .map((e) => SizedBox(
                                        height: 40.0,
                                        child: Center(
                                            child: Text(TABS[e % 2].label)),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: TabBarView(
                                  controller: tabController,
                                  //physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    ListView.builder(
                                      itemCount:
                                          viewModel.entity.requests.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                            viewModel.entity.requests[index];
                                        return CustomProductBox(
                                          requiredId: item.requestId,
                                          photo: item.productPhoto,
                                          name: item.productName,
                                          description: item.message,
                                          price: item.price,
                                          requestCount: item.requestCount,
                                          supportCount: item.supportCount,
                                          progress: item.supportCount /
                                              item.requestCount,
                                        );
                                      },
                                      padding:
                                          const EdgeInsets.only(bottom: 100),
                                    ),
                                    Container(
                                      color: CustomColor.mainColor,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: kPaddingMiddleSize,
                                          ),
                                          OrphanageDateForm(
                                            title: "일시",
                                            iconData: Icons.calendar_today,
                                            controller:
                                                viewModel.dateTextController,
                                          ),
                                          const SizedBox(
                                            height: kPaddingSmallSize,
                                          ),
                                          Expanded(
                                            child: OrphanageTextForm(
                                              title: "사유",
                                              iconData: Icons.description,
                                              controller: viewModel
                                                  .purposeTextController,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: kPaddingMiddleSize,
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }
}
