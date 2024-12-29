import 'package:chrip_aid/common/component/custom_image_category_card.dart';
import 'package:chrip_aid/common/component/custom_description_card.dart';
import 'package:chrip_aid/common/component/custom_app_bar.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:chrip_aid/root_tab/view/tab_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/root_tab/viewmodel/root_tab_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:chrip_aid/member/viewmodel/orphanage_member_info_viewmodel.dart';

class OrphanageHomeScreen extends TabScreen {
  @override
  const OrphanageHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 메인 페이지 호출 시 서버로부터 정보 받아옴
    final viewmodel = ref.read(orphanageMemberInfoViewmodelProvider)..getInfo();
    final rootTabViewModel = ref.read(rootTabViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white, // 배경색 지정
      body: Column(
        children: [
          const CustomAppBar(), // CustomAppBar를 상단에 추가
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(kPaddingSmallSize),
              child: Center(
                child: SizedBox(
                  width: 600.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: kPaddingLargeSize),
                      CustomImageCategoryCard(
                        title: "보육원 관리",
                        subtitle: "보육원의 예약 및 후원 정보를 관리하세요",
                        imagePath: "assets/image/management.png", // 아이콘 경로
                        backgroundColor: Colors.green.withOpacity(0.65), // 배경색
                        textColor: Colors.white,
                        onPressed: () {
                          rootTabViewModel.rootTabController.animateTo(1); // 보육원 관리 탭 이동
                        },
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomImageCategoryCard(
                        title: "후원 인증글 관리",
                        subtitle: "보육원의 후원 인증글을 관리하세요",
                        imagePath: "assets/image/giving.png", // 아이콘 경로
                        backgroundColor: Colors.blue.withOpacity(0.65), // 배경색
                        textColor: Colors.white,
                        onPressed: () {
                          rootTabViewModel.rootTabController.animateTo(2); // 인증글 관리 탭 이동
                        },
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomImageCategoryCard(
                        title: "방문 신청 관리",
                        subtitle: "보육원 방문 신청 내역을 관리하세요",
                        imagePath: "assets/image/calendar.png", // 아이콘 경로
                        backgroundColor: Colors.orange.withOpacity(0.65), // 배경색
                        textColor: Colors.white,
                        onPressed: () {
                          rootTabViewModel.rootTabController.animateTo(3); // 방문 신청 관리 탭 이동
                        },
                      ),
                      const SizedBox(height: kPaddingLargeSize),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "앱 특징",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      Center(
                        child: Container(
                          width: 600,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomDescriptionCard(
                                title: "효율적인 예약 관리",
                                description: "보육원 예약 내역을 간편하게 확인하고 관리하세요",
                                onTap: () {
                                  print("첫 번째 설명 클릭됨");
                                },
                              ),
                              CustomDescriptionCard(
                                title: "투명한 후원 인증",
                                description: "투명하게 후원 인증을 관리하고 사용자와 소통하세요",
                                onTap: () {
                                  print("두 번째 설명 클릭됨");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: kPaddingLargeSize),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.itemMainColor,
        onPressed: () => context.go('/chatting'), // GoRouter로 채팅 페이지 이동
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}