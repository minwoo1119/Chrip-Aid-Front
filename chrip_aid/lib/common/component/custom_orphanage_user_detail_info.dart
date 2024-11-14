import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import '../../admin/viewmodel/admin_accountmanagement_viewmodel.dart';
import '../styles/colors.dart';
import '../styles/sizes.dart';
import 'custom_user_list.dart';

class CustomOrphanageUserDetailInfo extends ConsumerWidget {
  final String orphanageUserId;
  final String name;
  final String email;
  final Map<String, int> orphanageId;

  const CustomOrphanageUserDetailInfo({
    super.key,
    required this.name,
    required this.email,
    required this.orphanageId,
    required this.orphanageUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(adminAccountManagementViewModelProvider)
      ..getUserList();

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '계정 관리',
      titleColor: Colors.white,
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
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  '이름',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('${name}'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '아이디',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('${email}'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '유저ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('${orphanageUserId}'),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      '보육원ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('${orphanageId}'),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('ElevatedButton pressed');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          Text('수정'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('ElevatedButton pressed');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          Text('삭제'),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
