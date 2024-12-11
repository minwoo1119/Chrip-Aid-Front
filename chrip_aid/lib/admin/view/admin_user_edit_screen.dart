import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/admin/model/dto/user_edit_dto.dart';
import 'package:chrip_aid/admin/viewmodel/admin_user_edit_viewmodel.dart';
import '../../../auth/model/type/region/sub_region.dart';
import '../../../auth/model/type/sex.dart';
import '../../auth/model/type/region.dart';

class AdminUserEditScreen extends ConsumerStatefulWidget {
  final String userId;

  const AdminUserEditScreen({super.key, required this.userId});

  @override
  _AdminUserEditScreenState createState() => _AdminUserEditScreenState();
}

class _AdminUserEditScreenState extends ConsumerState<AdminUserEditScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  Sex? selectedSex;
  MajorRegion? selectedMajorRegion;
  SubRegion? selectedSubRegion;

  @override
  void initState() {
    super.initState();
    _loadUserDetails(); // 초기 데이터 로드
  }

  Future<void> _loadUserDetails() async {
    final viewModel = ref.read(adminUserEditViewModelProvider);

    try {
      final userDetail = await viewModel.getUserDetails(widget.userId); // 유저 정보 로드
      setState(() {
        nameController.text = userDetail!.name;
        emailController.text = userDetail.email;
        ageController.text = userDetail.age.toString();
        selectedSex = userDetail.sex;
        nicknameController.text = userDetail.nickname;
        selectedMajorRegion = MajorRegion.fromString(userDetail.region.majorRegion.fullName);
        selectedSubRegion = userDetail.region;
        phoneNumberController.text = userDetail.phoneNumber;
      });
    } catch (e) {
      print('Error loading user details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(adminUserEditViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password (Optional)'),
              obscureText: true,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),

            // 성별 선택 DropDown
            DropdownButtonFormField<Sex>(
              value: selectedSex,
              items: Sex.values.map((sex) {
                return DropdownMenuItem<Sex>(
                  value: sex,
                  child: Text(sex.string),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSex = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Sex'),
            ),
            const SizedBox(height: 16.0),

            // 대지역 선택 DropDown
            DropdownButtonFormField<MajorRegion>(
              value: selectedMajorRegion,
              items: MajorRegion.values.map((region) {
                return DropdownMenuItem<MajorRegion>(
                  value: region,
                  child: Text(region.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedMajorRegion = newValue;
                  selectedSubRegion = null; // 대지역 변경 시 소지역 초기화
                });
              },
              decoration: const InputDecoration(labelText: 'Major Region'),
            ),
            const SizedBox(height: 16.0),

            // 소지역 선택 DropDown
            if (selectedMajorRegion != null)
              DropdownButtonFormField<SubRegion>(
                value: selectedSubRegion,
                items: selectedMajorRegion!.subTypes.map((subRegion) {
                  return DropdownMenuItem<SubRegion>(
                    value: subRegion,
                    child: Text(subRegion.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSubRegion = newValue;
                  });
                },
                decoration: const InputDecoration(labelText: 'Sub Region'),
              ),
            const SizedBox(height: 16.0),

            TextField(
              controller: nicknameController,
              decoration: const InputDecoration(labelText: 'Nickname'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final dto = UserEditDto(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text.isNotEmpty ? passwordController.text : null,
                  age: int.tryParse(ageController.text) ?? 0,
                  sex: selectedSex?.value ?? 'm', // 선택된 성별의 value 사용
                  nickname: nicknameController.text,
                  region: selectedSubRegion?.toJson() ?? '', // 선택된 소지역의 JSON 값 사용
                  phoneNumber: phoneNumberController.text,
                  profilePhoto: '', // 제거된 필드
                  role: '', // 제거된 필드
                );

                try {
                  await viewModel.updateUser(widget.userId, dto);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User updated successfully')),
                  );
                  Navigator.of(context).pop(); // 이전 페이지로 이동
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating user: $e')),
                  );
                }
              },
              child: const Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
