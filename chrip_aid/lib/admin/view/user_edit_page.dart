import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../admin/viewmodel/admin_accountmanagement_viewmodel.dart';
import 'package:go_router/go_router.dart';

import '../model/dto/user_edit_dto.dart';

class UserEditPage extends ConsumerWidget {
  final String userId;

  UserEditPage({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(adminAccountManagementViewModelProvider);

    // 사용자의 정보를 로드합니다.
    Future<void> _loadUserData() async {
      await viewModel.getUserDetailInfo(userId);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData(); // 페이지 로드 시 데이터를 불러옵니다.
    });

    final userDetailState = ref.watch(viewModel.userDetailState as ProviderListenable);

    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 수정'),
      ),
      body: userDetailState.when(
        loading: () => Center(child: CircularProgressIndicator()), // 데이터 로딩 중
        success: (userDetail) {
          // 폼에 데이터를 채우고 수정할 수 있도록 설정
          final nameController = TextEditingController(text: userDetail.name);
          final emailController = TextEditingController(text: userDetail.email);
          final passwordController = TextEditingController(); // 비밀번호는 빈 칸으로
          final ageController = TextEditingController(text: userDetail.age.toString());
          final sexController = TextEditingController(text: userDetail.sex);
          final nicknameController = TextEditingController(text: userDetail.nickname);
          final regionController = TextEditingController(text: userDetail.region);
          final phoneNumberController = TextEditingController(text: userDetail.phoneNumber);
          final profilePhotoController = TextEditingController(text: userDetail.profilePhoto);
          final roleController = TextEditingController(text: userDetail.role);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: '이름'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: '이메일'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: '비밀번호'),
                  obscureText: true, // 비밀번호는 가려지도록 설정
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: '나이'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: sexController,
                  decoration: InputDecoration(labelText: '성별'),
                ),
                TextField(
                  controller: nicknameController,
                  decoration: InputDecoration(labelText: '닉네임'),
                ),
                TextField(
                  controller: regionController,
                  decoration: InputDecoration(labelText: '지역'),
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: '전화번호'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: profilePhotoController,
                  decoration: InputDecoration(labelText: '프로필 사진 URL'),
                ),
                TextField(
                  controller: roleController,
                  decoration: InputDecoration(labelText: '역할'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // 수정된 데이터를 서버로 전송합니다.
                    try {
                      await viewModel.updateUser(
                        userId,
                        UserEditDto(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text.isNotEmpty
                              ? passwordController.text
                              : null, // 비밀번호는 변경되지 않을 수도 있음
                          age: int.tryParse(ageController.text) ?? userDetail.age,
                          sex: sexController.text,
                          nickname: nicknameController.text,
                          region: regionController.text,
                          phoneNumber: phoneNumberController.text,
                          profilePhoto: profilePhotoController.text,
                          role: roleController.text,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('사용자가 성공적으로 수정되었습니다.')),
                      );
                      context.pop(); // 수정 완료 후 이전 페이지로 돌아가기
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('사용자 수정 중 오류가 발생했습니다: $e')),
                      );
                    }
                  },
                  child: Text('수정 완료'),
                ),
              ],
            ),
          );
        },
        error: (message) => Center(child: Text('오류가 발생했습니다: $message')),
      ),
    );
  }
}
