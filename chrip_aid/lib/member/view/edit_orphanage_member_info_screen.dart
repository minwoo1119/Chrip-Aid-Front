import 'package:chrip_aid/auth/util/validators.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/member/viewmodel/edit_orphanage_member_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditOrphanageMemberInfoScreen extends ConsumerWidget
    implements EditMemberInfoScreen {
  const EditOrphanageMemberInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editOrphanageMemberInfoViewModelProvider);
    return DefaultLayout(
      backgroundColor: CustomColor.mainColor,
      title: "회원 정보 수정",
      leading: IconButton(
        onPressed: context.pop,
        icon: const Icon(
          Icons.navigate_before,
          color: CustomColor.backgroundMainColor,
          size: kIconLargeSize,
        ),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingSmallSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField(
                labelText: "비밀번호",
                hintText: "Password",
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => validateName(value),
                textController: viewModel.passwordTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField(
                labelText: "비밀번호 확인",
                hintText: "Check Password",
                prefixIcon: Icons.password,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => validateName(value),
                textController: viewModel.checkPasswordTextController,
              ),
              const SizedBox(height: kPaddingSmallSize),
              const Divider(color: CustomColor.textReverseColor, thickness: 2),
              const SizedBox(height: kPaddingSmallSize),
              CustomTextFormField(
                labelText: "이름",
                hintText: "Name",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (value) => validateName(value),
                textController: viewModel.nameTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              if (viewModel.userInfoState.isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.backGroundSubColor,
                  ),
                )
              else
                CustomOutlinedButton(
                  onPressed: () => viewModel.editUserInfo(context),
                  text: '정보 수정',
                ),
              const SizedBox(height: kPaddingXLargeSize),
            ],
          ),
        ),
      ),
    );
  }
}
