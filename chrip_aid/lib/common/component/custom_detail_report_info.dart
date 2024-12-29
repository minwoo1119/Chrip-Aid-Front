import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import '../../admin/viewmodel/admin_accountmanagement_viewmodel.dart';
import '../styles/colors.dart';
import '../styles/sizes.dart';

class CustomDetailReportInfo extends ConsumerWidget {
  final String title;
  final String target;
  final String writtenAt;
  final String email;
  final String nickname;
  final String content;

  const CustomDetailReportInfo({
    super.key,
    required this.title,
    required this.target,
    required this.writtenAt,
    required this.content,
    required this.nickname,
    required this.email,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(adminAccountManagementViewModelProvider)..getUserList();

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '신고 관리',
      titleColor: CustomColor.textReverseColor,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () => {},
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),),
                  SizedBox(height: 20.0,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage('assets/image/logo.png'),
                            height: 100,
                            width: 100,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '신고자',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Text('${nickname}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '아이디',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Text('${email}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '닉네임',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Text('${nickname}'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '상세 신고 사유',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(width: 15.0,),
                      Text('${content}'),
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
