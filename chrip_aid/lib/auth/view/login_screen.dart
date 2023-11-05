import 'package:chrip_aid/auth/provider/user_type_provider.dart';
import 'package:chrip_aid/auth/util/validators.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:chrip_aid/common/component/custom_text_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    return DefaultLayout(
      backgroundColor: CustomColor.mainColor,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingSmallSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: kPaddingXLargeSize),
              Center(
                child: Image.asset(
                  'assets/image/logo.png',
                  height: MediaQuery.of(context).size.height / 3,
                ),
              ),
              const SizedBox(height: kPaddingXLargeSize),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => viewModel.toggleAuthorityType(
                      viewModel.authority != AuthorityType.orphanage,
                    ),
                    splashColor: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: kIconSmallSize,
                          height: kIconSmallSize,
                          child: Checkbox(
                            value:
                                viewModel.authority == AuthorityType.orphanage,
                            onChanged: viewModel.toggleAuthorityType,
                            activeColor: CustomColor.mainColor,
                            side: const BorderSide(
                              color: CustomColor.textReverseColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: kPaddingSmallSize),
                        Text(
                          "보육원장 이신가요?",
                          style: kTextReverseStyleSmall.copyWith(
                            height: kIconMiniSize / kTextSmallSize,
                          ),
                        ),
                        const SizedBox(width: kPaddingMiniSize),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              if (viewModel.state is LoadingState)
                const Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.backGroundSubColor,
                  ),
                )
              else
                Column(
                  children: [
                    CustomOutlinedButton(
                      onPressed: viewModel.login,
                      text: '로그인',
                    ),
                    const SizedBox(height: kPaddingMiddleSize),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: CustomTextButton(
                            onPressed: null,
                            text: 'ID / PW 찾기',
                          ),
                        ),
                        const SizedBox(width: kPaddingMiddleSize),
                        Expanded(
                          child: CustomTextButton(
                            onPressed: () =>
                                viewModel.navigateToSignupPage(context),
                            text: '회원이 아니신가요?',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
