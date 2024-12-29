import 'package:chrip_aid/common/component/custom_image_category_card.dart';
import 'package:chrip_aid/common/component/custom_description_card.dart';
import 'package:chrip_aid/common/component/custom_app_bar.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:chrip_aid/root_tab/view/tab_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/root_tab/viewmodel/root_tab_viewmodel.dart';

class UserHomeScreen extends TabScreen {
  @override
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootTabViewModel = ref.read(rootTabViewModelProvider);
    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.itemMainColor,
        onPressed: () => _navigateToChattingPage(context),
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: Colors.white,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kPaddingSmallSize),
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 600.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 앱 특징 왼쪽 정렬
                    children: [
                      const SizedBox(height: kPaddingLargeSize),
                      const SizedBox(height: kPaddingLargeSize),
                      CustomImageCategoryCard(
                        title: "우리동네 보육원 찾기",
                        subtitle: "지역 내 보육원을 쉽고 빠르게 검색하세요",
                        imagePath: "assets/image/pin.png", // 아이콘 경로
                        backgroundColor: Colors.pink.withOpacity(0.65), // 배경색
                        textColor: Colors.white,
                        onPressed: () {
                          rootTabViewModel.rootTabController.animateTo(1); // 보육원 검색 탭으로 이동
                        },
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomImageCategoryCard(
                        title: "후원 인증글",
                        subtitle: "다른 사용자의 기부 활동을 확인하고\n기부에 동참해보세요",
                        imagePath: "assets/image/giving.png", // 아이콘 경로
                        backgroundColor: Colors.blue.withOpacity(0.65), // 배경색
                        textColor: Colors.white,
                        onPressed: () {
                          rootTabViewModel.rootTabController.animateTo(2); // 인증글 확인 탭으로 이동
                        },
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomImageCategoryCard(
                        title: "방문 신청 내역",
                        subtitle: "보육원 방문 신청 내역을 관리하세요",
                        imagePath: "assets/image/calendar.png", // 아이콘 경로
                        backgroundColor: Colors.orange.withOpacity(0.65), // 배경색
                        textColor: Colors.white,
                        onPressed: () {
                          rootTabViewModel.rootTabController.animateTo(3); // 신청 내역 탭으로 이동
                        },
                      ),
                      const SizedBox(height: kPaddingLargeSize),
                      // 앱 특징 텍스트와 박스
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
                          width: 600, // 전체 가로 크기
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0, // 회색 테두리
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomDescriptionCard(
                                title: "크롤링 기반 기부금 책정",
                                description: "자동화된 크롤링으로 투명한 기부금 계산 및 관리",
                                onTap: () {
                                  print("첫 번째 설명 클릭됨");
                                },
                              ),
                              CustomDescriptionCard(
                                title: "실시간 채팅 피드백",
                                description: "사용자와 실시간으로 소통하며 문제를 해결하세요",
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
          const Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: CustomAppBar(), // 화면 전체 너비 사용
          ),
        ],
      ),
    );
  }

  void _navigateToChattingPage(BuildContext context) {
    Navigator.pushNamed(context, '/chatting');
  }
}
