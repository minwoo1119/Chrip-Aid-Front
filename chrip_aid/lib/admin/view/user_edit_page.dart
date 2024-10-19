import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../admin/viewmodel/admin_accountmanagement_viewmodel.dart';
import 'package:go_router/go_router.dart';

import '../../auth/model/type/region/sub_region.dart';
import '../model/dto/user_edit_dto.dart';
import '../../auth/model/type/region.dart'; // SubRegion 파일 경로

class UserEditPage extends ConsumerWidget {
  final String userId;

  const UserEditPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(adminAccountManagementViewModelProvider);

    // 사용자의 정보를 로드합니다.
    Future<void> loadUserData() async {
      await viewModel.getUserDetailInfo(userId);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData(); // 페이지 로드 시 데이터를 불러옵니다.
    });

    final userDetailState = viewModel.userDetailState;

    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 수정'),
      ),
      body: Builder(
        builder: (context) {
          if (userDetailState.isLoading) {
            return Center(child: CircularProgressIndicator()); // 데이터 로딩 중
          } else if (userDetailState.isError) {
            return Center(child: Text('오류가 발생했습니다: ${userDetailState.message}'));
          } else if (userDetailState.isSuccess && userDetailState.value != null) {
            final userDetail = userDetailState.value!;

            // 폼에 데이터를 채우고 수정할 수 있도록 설정
            final nameController = TextEditingController(text: userDetail.name);
            final emailController = TextEditingController(text: userDetail.email);
            final passwordController = TextEditingController(); // 비밀번호는 빈 칸으로
            final ageController = TextEditingController(text: userDetail.age.toString());
            String selectedSex = userDetail.sex.value; // 현재 성별 값
            SubRegion selectedRegion = userDetail.region; // 현재 지역 값
            final nicknameController = TextEditingController(text: userDetail.nickname);
            final phoneNumberController = TextEditingController(text: userDetail.phoneNumber);
            final profilePhotoController = TextEditingController(text: userDetail.profilePhoto);
            final roleController = TextEditingController(text: userDetail.role);

            // MajorRegion 하위에 속한 SubRegion 목록 가져오기
            final allSubRegions = MajorRegion.values.expand((major) => major.subTypes).toList();

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

                  // 성별 선택 DropDown
                  DropdownButton<String>(
                    value: selectedSex,
                    items: ['m', 'f'].map((String sex) {
                      return DropdownMenuItem<String>(
                        value: sex,
                        child: Text(sex == 'm' ? '남성' : '여성'),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedSex = newValue!;
                    },
                    isExpanded: true,
                    hint: Text("성별을 선택하세요"),
                  ),

                  // 지역 선택 DropDown
                  DropdownButton<SubRegion>(
                    value: selectedRegion,
                    items: allSubRegions.map((SubRegion region) {
                      return DropdownMenuItem<SubRegion>(
                        value: region,
                        child: Text(region.toJson()), // MajorRegion과 SubRegion 이름을 출력
                      );
                    }).toList(),
                    onChanged: (SubRegion? newValue) {
                      if (newValue != null) {
                        selectedRegion = newValue;
                      }
                    },
                    isExpanded: true,
                    hint: Text("지역을 선택하세요"),
                  ),

                  TextField(
                    controller: nicknameController,
                    decoration: InputDecoration(labelText: '닉네임'),
                  ),
                  TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(labelText: '전화번호'),
                    keyboardType: TextInputType.phone,
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
                            sex: selectedSex, // 선택된 성별 사용
                            nickname: nicknameController.text,
                            region: selectedRegion.toJson(), // 선택된 지역 사용
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
          } else {
            return Center(child: Text('데이터를 불러올 수 없습니다.'));
          }
        },
      ),
    );
  }
}
