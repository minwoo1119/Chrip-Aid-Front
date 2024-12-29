import 'package:chrip_aid/admin/model/dto/orphanage_user_edit_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:go_router/go_router.dart';
import '../../admin/viewmodel/admin_accountmanagement_viewmodel.dart';
import '../styles/colors.dart';
import '../styles/sizes.dart';

class CustomDetailInfo extends ConsumerWidget {
  final String userId; // 사용자 ID 추가
  final String name;
  final String email;
  final String phoneNumber;
  final String nickname;
  final String age;
  final String sex;
  final String region;

  const CustomDetailInfo({
    super.key,
    required this.userId, // 사용자 ID 추가
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
    final viewModel = ref.read(adminAccountManagementViewModelProvider);

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '계정 관리',
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
                                SizedBox(width: 10.0),
                                Text(name),
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
                                SizedBox(width: 10.0),
                                Text(email),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '별명',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Text(nickname),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              children: [
                                Text(
                                  '나이',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10.0),
                                Text(age),
                              ],
                            ),
                          ),
                          SizedBox(width: 100),
                          Row(
                            children: [
                              Text(
                                '성별',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10.0),
                              Text(sex),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        children: [
                          Text(
                            '전화번호',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10.0),
                          Text(phoneNumber),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        children: [
                          Text(
                            '지역',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10.0),
                          Text(region),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _navigateEditPage(context),
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          Text('수정'),
                        ],
                      ),
                    ),

                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await viewModel.deleteUser(userId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('사용자가 삭제되었습니다.')),
                          );

                          // 삭제 완료 후 이전 페이지로 true 반환
                          Navigator.pop(context, true);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('사용자 삭제 중 오류가 발생했습니다: $e')),
                          );
                        }
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

  void _navigateEditPage(BuildContext context) {
    context.push(
      '/admin/accountmanagement/user/detail/edit',
      extra: userId,
    );
  }
}
