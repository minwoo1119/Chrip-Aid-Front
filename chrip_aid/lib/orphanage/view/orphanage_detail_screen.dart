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
  OrphanageDetailPageState createState() => OrphanageDetailPageState();
}

class OrphanageDetailPageState extends ConsumerState<OrphanageDetailScreen>
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
          child: Icon(
            fabIcon,
            size: kIconLargeSize,
          ),
          onPressed: () {},
        ),
      ),
      child: viewModel.state is SuccessState
          ? Column(
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: kPaddingMiddleSize,
                    right: kPaddingMiddleSize,
                    top: kPaddingMiniSize,
                    bottom: kPaddingSmallSize,
                  ),
                  child: Column(
                    children: [
                      CustomTextField(iconData: Icons.description, text: "소개글"),
                      Text(
                        "사시사철 웃음가득, 기쁨 가득 파주키즈 동산에 방문하신 여러분을 환영합니다! 아이들을 사랑하는 마음들이 모아져 여러분들과 함께 기쁨의 공간을 채우고 나누게 되어 매우 기쁘게 생각합니다.",
                        style: kTextContentStyleSmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 5.0,
                  color: CustomColor.disabledColor.withOpacity(0.5),
                ),
                Expanded(
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
                            .map((e) => Container(
                                  height: 40.0,
                                  child: Center(child: Text(TABS[e % 2].label)),
                                ))
                            .toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                            controller: tabController,
                            //physics: NeverScrollableScrollPhysics(),
                            children: [
                              ListView(
                                children: const [
                                  CustomProductBox(
                                    photo: 'assets/image/choco_pie.jpg',
                                    name: "초코파이",
                                    description:
                                        "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
                                    price: 8630.0,
                                    requestCount: 30,
                                    supportCount: 21,
                                    progress: 0.7,
                                  ),
                                  CustomProductBox(
                                    photo: 'assets/image/choco_pie.jpg',
                                    name: "초코파이",
                                    description:
                                        "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
                                    price: 8630.0,
                                    requestCount: 30,
                                    supportCount: 21,
                                    progress: 0.7,
                                  ),
                                  CustomProductBox(
                                    photo: 'assets/image/choco_pie.jpg',
                                    name: "초코파이",
                                    description:
                                        "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
                                    price: 8630.0,
                                    requestCount: 30,
                                    supportCount: 21,
                                    progress: 0.7,
                                  ),
                                  CustomProductBox(
                                    photo: 'assets/image/choco_pie.jpg',
                                    name: "초코파이",
                                    description:
                                        "달달하고 맛있는 초코파이가 먹고 싶어요. 렌지에 약간 뎁혀 먹어도 맛있어요.",
                                    price: 8630.0,
                                    requestCount: 30,
                                    supportCount: 21,
                                    progress: 21 / 30,
                                  ),
                                ],
                              ),
                              Container(
                                color: CustomColor.mainColor,
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: kPaddingMiddleSize,
                                    ),
                                    OrphanageTextForm(
                                      title: "일시",
                                      iconData: Icons.calendar_today,
                                    ),
                                    SizedBox(
                                      height: kPaddingSmallSize,
                                    ),
                                    Expanded(
                                      child: OrphanageTextForm(
                                        title: "사유",
                                        iconData: Icons.description,
                                      ),
                                    ),
                                    SizedBox(
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
