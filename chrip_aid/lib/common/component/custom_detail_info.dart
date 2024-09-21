import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../supervisor/viewmodel/supervisor_accountmanagement_viewmodel.dart';
import '../styles/colors.dart';
import '../styles/sizes.dart';

class CustomDetailInfo extends ConsumerWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String nickname;
  final String age;
  final String sex;
  final String region;

  const CustomDetailInfo({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.nickname,
    required this.age,
    required this.sex,
    required this.region,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(supervisorAccountManagementViewModelProvider)..getInfo();

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '계정 관리',
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
      child: Container(
        child: Column(
          children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Image(
                       image: AssetImage('./assets/image/logo.png'),
                       height: 100,
                       width: 100,
                     ),
                     Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('이름  ${name}'),
                         Text('아이디 ${email}'),
                         Text('별명 ${nickname}'),
                       ],
                     )
                   ],
                 )
               ],
             ),
             Column(
               children: [
                 Container(
                   margin: EdgeInsets.all(30.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('나이 ${age}'),
                       SizedBox(width: 100,),
                       Text('성별 ${sex}'),
                     ],
                   ),
                 )
               ],
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('전화번호 ${phoneNumber}'),
                 Text('지역 ${region}'),
               ],
             ),
             Column(
               children: [
                 Text('활동 내역'),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
