import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/root_tab/viewmodel/root_tab_viewmodel.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(80.0),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootTabViewModel = ref.watch(rootTabViewModelProvider);

    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chirp Aid",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "보육원과 마음을 잇는 플랫폼",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: 28.0,
          ),
          onPressed: () {
            // 하단바 알람 탭으로 전환
            rootTabViewModel.rootTabController.animateTo(0);
          },
        ),
      ],
    );
  }
}
