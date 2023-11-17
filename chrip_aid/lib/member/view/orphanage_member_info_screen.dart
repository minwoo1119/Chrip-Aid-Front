import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/common/view/tab_screen.dart';
import 'package:chrip_aid/member/component/designed_container_title_bar.dart';
import 'package:chrip_aid/member/viewmodel/orphanage_member_info_viewmodel.dart';
import 'package:chrip_aid/orphanage/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageMemberInfoScreen extends TabScreen {
  @override
  Color get mainColor => CustomColor.thirdColor;

  const OrphanageMemberInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(orphanageMemberInfoViewmodelProvider)
      ..getInfo();
    return DefaultLayout(
      title: '사용자 정보',
      appbarColor: mainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      child: Padding(
        padding: const EdgeInsets.all(kPaddingSmallSize),
        child: viewmodel.orphanageInfo == null
            ? const Center(child: CircularProgressIndicator())
            : ValueStateListener(
                state: viewmodel.memberState,
                successBuilder: (_, state) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: mainColor,
                            width: kBorderWidth,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(kBorderRadiusSize),
                          ),
                        ),
                        padding: const EdgeInsets.all(kPaddingSmallSize),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Image.asset(
                                'assets/image/logo.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const SizedBox(width: kPaddingSmallSize),
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  DesignedContainerTitleBar(
                                    title:
                                        viewmodel.orphanageInfo!.orphanageName,
                                    actions: [
                                      IconButton(
                                        onPressed: () => viewmodel
                                            .navigateToEditUserInfoPage(
                                                context),
                                        icon: const Icon(Icons.edit),
                                        iconSize: kIconSmallSize,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: kPaddingSmallSize,
                                        ),
                                        constraints: const BoxConstraints(),
                                        splashRadius: kIconSmallSize,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: kPaddingMiddleSize),
                                  CustomTextField(
                                    iconData: Icons.person,
                                    text: state.value!.name,
                                  ),
                                  const SizedBox(height: kPaddingMiniSize),
                                  CustomTextField(
                                    iconData: Icons.email,
                                    text: state.value!.email,
                                  ),
                                  const SizedBox(height: kPaddingMiniSize),
                                  CustomTextField(
                                    iconData: Icons.phone,
                                    text: viewmodel.orphanageInfo!.phoneNumber,
                                  ),
                                  const SizedBox(height: kPaddingMiniSize),
                                  CustomTextField(
                                    iconData: Icons.location_on,
                                    text: viewmodel.orphanageInfo!.address,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kPaddingSmallSize),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: mainColor,
                            width: kBorderWidth,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(kBorderRadiusSize),
                          ),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () =>
                                  viewmodel.navigateToDonatePage(context),
                              child: const Padding(
                                padding: EdgeInsets.all(kPaddingSmallSize),
                                child: DesignedContainerTitleBar(
                                  title: '후원 내역',
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                      right: kPaddingSmallSize,
                                    ),
                                    child: Icon(
                                      Icons.receipt_long,
                                      size: kIconSmallSize,
                                    ),
                                  ),
                                  actions: [
                                    Icon(
                                      Icons.navigate_next,
                                      size: kIconSmallSize,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: mainColor,
                              thickness: kBorderWidth,
                              height: 0,
                            ),
                            InkWell(
                              // TODO : add function (navigate to credit page)
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(kPaddingSmallSize),
                                child: DesignedContainerTitleBar(
                                  title: '후원 계좌',
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                      right: kPaddingSmallSize,
                                    ),
                                    child: Icon(
                                      Icons.credit_card,
                                      size: kIconSmallSize,
                                    ),
                                  ),
                                  actions: [
                                    Icon(
                                      Icons.navigate_next,
                                      size: kIconSmallSize,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: mainColor,
                              thickness: kBorderWidth,
                              height: 0,
                            ),
                            InkWell(
                              // TODO : add function (navigate to setting page)
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(kPaddingSmallSize),
                                child: DesignedContainerTitleBar(
                                  title: '설정',
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                      right: kPaddingSmallSize,
                                    ),
                                    child: Icon(
                                      Icons.settings,
                                      size: kIconSmallSize,
                                    ),
                                  ),
                                  actions: [
                                    Icon(
                                      Icons.navigate_next,
                                      size: kIconSmallSize,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: mainColor,
                              thickness: kBorderWidth,
                              height: 0,
                            ),
                            InkWell(
                              onTap: viewmodel.logout,
                              child: const Padding(
                                padding: EdgeInsets.all(kPaddingSmallSize),
                                child: DesignedContainerTitleBar(
                                  title: '로그아웃',
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                      right: kPaddingSmallSize,
                                    ),
                                    child: Icon(
                                      Icons.logout,
                                      size: kIconSmallSize,
                                    ),
                                  ),
                                  actions: [
                                    Icon(
                                      Icons.navigate_next,
                                      size: kIconSmallSize,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
