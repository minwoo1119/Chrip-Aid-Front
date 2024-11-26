import 'package:chrip_aid/auth/util/validators.dart';
import 'package:chrip_aid/auth/view/sign_up_screen.dart';
import 'package:chrip_aid/auth/viewmodel/user_sign_up_viewmodel.dart';
import 'package:chrip_aid/common/component/custom_dropdown_button_2.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field_2.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserSignUpScreen  extends ConsumerWidget implements SignUpScreen {
  const UserSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(userSignUpViewModelProvider);
    return DefaultLayout(
      backgroundColor: Colors.white,
      title: "Sign Up",
      titleStyle: const TextStyle(
        color: CustomColor.mainColor, // mainColor로 설정
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      leading: IconButton(
        onPressed: context.pop,
        icon: const Icon(
          Icons.navigate_before,
          color: CustomColor.mainColor,
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
              CustomTextFormField_2(
                hintText: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => validateEmail(value),
                textController: viewModel.idTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField_2(
                hintText: "Password",
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => validatePassword(value),
                textController: viewModel.passwordTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField_2(
                hintText: "Check Password",
                prefixIcon: Icons.password,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => validatePassword(value),
                textController: viewModel.checkPasswordTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField_2(
                hintText: "Name",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (value) => validateName(value),
                textController: viewModel.nameTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField_2(
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
                    child: CustomTextFormField_2(
                      hintText: "Age",
                      prefixIcon: Icons.calendar_today,
                      keyboardType: TextInputType.number,
                      validator: (value) => validateName(value),
                      textController: viewModel.ageTextController,
                    ),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  Expanded(
                    child: CustomDropdownButton_2(
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
                    child: CustomDropdownButton_2(
                      viewModel.majorRegionDropdownController,
                      leading: Icons.location_on,
                      action: Icons.arrow_drop_down,
                    ),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  Expanded(
                    child: CustomDropdownButton_2(
                      viewModel.subRegionDropdownController,
                      leading: Icons.location_on_outlined,
                      action: Icons.arrow_drop_down,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField_2(
                hintText: "Phone Number",
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) => validateName(value),
                textController: viewModel.phoneTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              ValueStateListener(
                state: viewModel.state,
                defaultBuilder: (_, __) => CustomOutlinedButton(
                  onPressed: () => viewModel.signup(context),
                  text: '회원가입',
                ),
                loadingBuilder: (_, __) => const CircularProgressIndicator(
                  color: CustomColor.backGroundSubColor,
                ),
              ),
              const SizedBox(height: kPaddingXLargeSize),
            ],
          ),
        ),
      ),
    );
  }
}
