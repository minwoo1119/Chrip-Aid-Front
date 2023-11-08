import 'package:chrip_aid/auth/util/validators.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/member/viewmodel/edit_user_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditUserInfoScreen extends ConsumerWidget implements EditMemberInfoScreen {
  const EditUserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editUserInfoViewModelProvider);
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
              CustomTextFormField(
                labelText: "닉네임",
                hintText: "Nickname",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.text,
                validator: (value) => validateName(value),
                textController: viewModel.nicknameTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomTextFormField(
                      labelText: "나이",
                      hintText: "Age",
                      prefixIcon: Icons.calendar_today,
                      keyboardType: TextInputType.number,
                      validator: (value) => validateName(value),
                      textController: viewModel.ageTextController,
                    ),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  Expanded(
                    child: CustomDropdownButton(
                      viewModel.sexDropdownController,
                      leading: Icons.wc,
                      action: Icons.arrow_drop_down,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownButton(
                      viewModel.majorRegionDropdownController,
                      leading: Icons.location_on,
                      action: Icons.arrow_drop_down,
                      boarderColor: CustomColor.backgroundMainColor,
                    ),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  Expanded(
                    child: CustomDropdownButton(
                      viewModel.subRegionDropdownController,
                      leading: Icons.location_on_outlined,
                      action: Icons.arrow_drop_down,
                      boarderColor: CustomColor.backgroundMainColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField(
                labelText: "전화번호",
                hintText: "Phone Number",
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) => validateName(value),
                textController: viewModel.phoneTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              if (viewModel.userInfoState is LoadingState)
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
