import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import '../../supervisor/viewmodel/supervisor_accountmanagement_viewmodel.dart';
import '../styles/colors.dart';
import '../styles/sizes.dart';

class CustomDetailReportInfo extends ConsumerWidget {
  final String title;
  final String target;
  final String writtenAt;
  final String user;

  const CustomDetailReportInfo({
    super.key,
    required this.title,
    required this.target,
    required this.writtenAt,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(supervisorAccountManagementViewModelProvider)..getInfo();

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '게시글 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () => viewModel.navigateToEditOrphanageScreen(context),
          icon: const Icon(Icons.search, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
              child:Column(
                children: [
                  Text('Hate You '),
                ],
              )
          ),
        ),
      ),
    );
  }
}
