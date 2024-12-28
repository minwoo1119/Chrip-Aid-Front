import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/root_tab/viewmodel/root_tab_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with TickerProviderStateMixin {
  late final RootTabViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(rootTabViewModelProvider)..getInfo(this);

    // TabController의 상태 변경 리스너 추가
    viewModel.rootTabController.addListener(() {
      if (mounted) {
        setState(() {}); // TabController의 변경 사항을 반영
      }
    });
  }

  @override
  void dispose() {
    viewModel.rootTabController.dispose(); // TabController 리소스 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: CustomColor.backGroundSubColor,
        selectedItemColor: CustomColor.mainColor,
        unselectedItemColor: CustomColor.contentSubColor,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          viewModel.rootTabController.animateTo(index); // Tab 전환
        },
        currentIndex: viewModel.rootTabController.index, // TabController와 동기화
        items: viewModel.tabs
            .map(
              (e) => BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.label,
          ),
        )
            .toList(),
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
      child: TabBarView(
        controller: viewModel.rootTabController,
        physics: const NeverScrollableScrollPhysics(),
        children: viewModel.tabs.map((e) => e.tab).toList(),
      ),
    );
  }
}

