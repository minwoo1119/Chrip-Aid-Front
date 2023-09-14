import 'package:chrip_aid/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:chrip_aid/common/const/tabs.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin {
  late TabController controller;
  int index = 1;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: TABS.length,
      animationDuration: Duration.zero,
      vsync: this,
      initialIndex: 1,
    );
    controller.addListener(tabListener);
  }

  void tabListener() => setState(() => index = controller.index);

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: MediaQuery.of(context).size.width > 700
          ? null
          : BottomNavigationBar(
              backgroundColor: CustomColor.mainColor,
              selectedItemColor: CustomColor.backGroundSubColor,
              unselectedItemColor: CustomColor.disabledColor.withOpacity(0.5),
              type: BottomNavigationBarType.fixed,
              onTap: (int index) => setState(() => controller.animateTo(index)),
              currentIndex: index,
              items: TABS
                  .map((e) => BottomNavigationBarItem(
                        icon: Icon(e.icon),
                        label: e.label,
                      ))
                  .toList(),
              showUnselectedLabels: false,
              showSelectedLabels: false,
            ),
      child: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        // TODO : Add Tab Screen
        children: const [
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
        ],
      ),
    );
  }

  NavigationRailDestination _destination(TabInfo info) {
    return NavigationRailDestination(
      indicatorShape: const RoundedRectangleBorder(),
      icon: Icon(info.icon),
      label: Text(info.label),
    );
  }
}
