import 'package:chrip_aid/common/component/custom_image_category_card.dart';
import 'package:chrip_aid/common/component/custom_app_bar.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/root_tab/view/tab_screen.dart';
import 'package:flutter/material.dart';
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
