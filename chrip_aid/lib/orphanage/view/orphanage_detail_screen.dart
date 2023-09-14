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
        if (tabController.index == 0) {
          fabIcon = Icons.shopping_cart;
          tabColor = Colors.white;
          tabTextColor = Colors.black;
        } else {
          fabIcon = Icons.edit_document;
          tabColor = CustomColor.mainColor;
          tabTextColor = Colors.white;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(orphanageDetailViewModelProvider);

    final tabs = [0, 1];
    return DetailPageLayout(
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          foregroundColor: CustomColor.mainColor,
          backgroundColor: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(color: CustomColor.mainColor, width: 2.0),
          ),
          onPressed: ()=>viewModel.postOrCheck(tabController.index),
          child: Icon(
            fabIcon,
            size: kIconLargeSize,
          ),
        ),
      ),
      child: viewModel.state is SuccessState
          ? SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
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
                      child:
                      Center(child: Text(TABS[e % 2].label)),
                    ))
                        .toList(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: TabBarView(
                        controller: tabController,
                        //physics: NeverScrollableScrollPhysics(),
                        children: [
                          ListView(
                            children: [
                              CustomProductBox(
                                photo: viewModel
                                    .entity.requests[0].productPhoto,
                                name: viewModel
                                    .entity.requests[0].productName,
                                description:
                                viewModel.entity.requests[0].message,
                                price: viewModel.entity.requests[0].price,
                                requestCount: viewModel
                                    .entity.requests[0].requestCount,
                                supportCount: viewModel
                                    .entity.requests[0].supportCount,
                                progress: viewModel
                                    .entity.requests[0].supportCount /
                                    viewModel
                                        .entity.requests[0].requestCount,
                                onPressed: () => viewModel.addProduct(
                                    viewModel
                                        .entity.requests[0].requestId,
                                    1),
                              ),
                              CustomProductBox(
                                photo: viewModel
                                    .entity.requests[1].productPhoto,
                                name: viewModel
                                    .entity.requests[1].productName,
                                description:
                                viewModel.entity.requests[1].message,
                                price: viewModel.entity.requests[1].price,
                                requestCount: viewModel
                                    .entity.requests[1].requestCount,
                                supportCount: viewModel
                                    .entity.requests[1].supportCount,
                                progress: viewModel
                                    .entity.requests[1].supportCount /
                                    viewModel
                                        .entity.requests[1].requestCount,
                                onPressed: () => viewModel.addProduct(
                                    viewModel
                                        .entity.requests[1].requestId,
                                    1),
                              ),
                              CustomProductBox(
                                photo: viewModel
                                    .entity.requests[2].productPhoto,
                                name: viewModel
                                    .entity.requests[2].productName,
                                description:
                                viewModel.entity.requests[2].message,
                                price: viewModel.entity.requests[2].price,
                                requestCount: viewModel
                                    .entity.requests[2].requestCount,
                                supportCount: viewModel
                                    .entity.requests[2].supportCount,
                                progress: viewModel
                                    .entity.requests[2].supportCount /
                                    viewModel
                                        .entity.requests[2].requestCount,
                                onPressed: () => viewModel.addProduct(
                                    viewModel
                                        .entity.requests[2].requestId,
                                    1),
                              ),
                              CustomProductBox(
                                photo: viewModel
                                    .entity.requests[3].productPhoto,
                                name: viewModel
                                    .entity.requests[3].productName,
                                description:
                                viewModel.entity.requests[3].message,
                                price: viewModel.entity.requests[3].price,
                                requestCount: viewModel
                                    .entity.requests[3].requestCount,
                                supportCount: viewModel
                                    .entity.requests[3].supportCount,
                                progress: viewModel
                                    .entity.requests[3].supportCount /
                                    viewModel
                                        .entity.requests[3].requestCount,
                                onPressed: () {
                                  viewModel.addProduct(
                                      viewModel
                                          .entity.requests[3].requestId,
                                      1);
                                },
                              ),
                            ],
                          ),
                          Container(
                            color: CustomColor.mainColor,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: kPaddingMiddleSize,
                                ),
                                OrphanageTextForm(
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
                                    controller:
                                    viewModel.purposeTextController,
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
    );
  }
}
