import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
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
  int index = 1;
  late final List<TabInfo> tabs;

  @override
  void initState() {
    super.initState();
    tabs = ref.read(tabProvider);
    rootTabController = TabController(
      length: tabs.length,
      animationDuration: Duration.zero,
      vsync: this,
      initialIndex: 1,
    );
    rootTabController.addListener(tabListener);
  }

  void tabListener() => setState(() => index = rootTabController.index);

  @override
  void dispose() {
    rootTabController.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: tabs[rootTabController.index].tab.mainColor,
        selectedItemColor: CustomColor.backGroundSubColor,
        unselectedItemColor: CustomColor.disabledColor.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => setState(() => rootTabController.animateTo(index)),
        currentIndex: index,
        items: tabs
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
              ),
            )
            .toList(),
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
      child: TabBarView(
        controller: rootTabController,
        physics: const NeverScrollableScrollPhysics(),
        children: tabs.map((e) => e.tab).toList(),
      ),
    );
  }
}
