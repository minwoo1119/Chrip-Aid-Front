import 'package:chrip_aid/auth/util/validators.dart';
import 'package:chrip_aid/auth/view/sign_up_screen.dart';
import 'package:chrip_aid/auth/viewmodel/orphanage_sign_up_viewmodel.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrphanageSignUpScreen extends ConsumerWidget implements SignUpScreen {
  const OrphanageSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(orphanageSignUpViewModelProvider);
    return DefaultLayout(
      backgroundColor: CustomColor.mainColor,
      title: "Chirp Aid",
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
                labelText: "이름",
                hintText: "Name",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (value) => validateName(value),
                textController: viewModel.nameTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField(
                labelText: "이메일",
                hintText: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => validateEmail(value),
                textController: viewModel.idTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField(
                labelText: "비밀번호",
                hintText: "Password",
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => validatePassword(value),
                textController: viewModel.passwordTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField(
                labelText: "비밀번호 확인",
                hintText: "Check Password",
                prefixIcon: Icons.password,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => validatePassword(value),
                textController: viewModel.checkPasswordTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomTextFormField(
                labelText: "보육원명 ",
                hintText: "Orphanage Name",
                prefixIcon: Icons.house,
                keyboardType: TextInputType.name,
                validator: (value) => validateName(value),
                textController: viewModel.orphanageNameTextController,
              ),
              const SizedBox(height: kPaddingMiddleSize),
              if (viewModel.state is LoadingState)
                const Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.backGroundSubColor,
                  ),
                )
              else
                CustomOutlinedButton(
                  onPressed: () => viewModel.signup(context),
                  text: '회원가입',
                ),
              const SizedBox(height: kPaddingXLargeSize),
            ],
          ),
        ),
      ),
    );
  }
}
