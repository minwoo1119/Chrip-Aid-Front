import 'package:chrip_aid/auth/model/state/authority_state.dart';
import 'package:chrip_aid/auth/util/validators.dart';
import 'package:chrip_aid/auth/viewmodel/login_viewmodel.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field_2.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(loginViewModelProvider)..getInfo();
    return DefaultLayout(
      backgroundColor: CustomColor.backGroundSubColor,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingSmallSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: kPaddingXLargeSize),
              Column(
                children: [
                  // Circular Background with Logo
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: CustomColor.mainColor, // 초록색 원 배경
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/image/logo.png',
                        width: 170,
                        height: 170,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // 원과 텍스트 간격
                  // App Name
                  Text(
                    "Chrip Aid",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.mainColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // App Description
                  Text(
                    "Orphanage Direct Donation Platform",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                textInputAction: TextInputAction.done, // 엔터 키 스타일 설정
                onFieldSubmitted: (_) => viewModel.login(context), // 엔터 시 로그인 호출
              ),
              const SizedBox(height: kPaddingMiddleSize),
              ValueStateListener(
                state: viewModel.authorityState,
                defaultBuilder: (_, state) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: viewModel.toggleAuthorityType,
                      splashColor: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: kIconSmallSize,
                            height: kIconSmallSize,
                            child: Checkbox(
                              value: state.value == AuthorityType.orphanage,
                              onChanged: (_) => viewModel.toggleAuthorityType(),
                              activeColor: CustomColor.mainColor,
                              side: const BorderSide(
                                color: CustomColor.mainColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: kPaddingSmallSize),
                          Text(
                            "Are you orphanage director?",
                            style: kTextReverseStyleSmall.copyWith(
                              height: kIconMiniSize / kTextSmallSize,
                              color: CustomColor.mainColor,
                            ),
                          ),
                          const SizedBox(width: kPaddingMiniSize),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kPaddingMiddleSize),
              ValueStateListener(
                state: viewModel.authState,
                defaultBuilder: (_, __) => CustomOutlinedButton(
                  onPressed: () => viewModel.login(context),
                  text: 'Login',
                ),
                loadingBuilder: (_, __) => const CircularProgressIndicator(
                  color: CustomColor.backGroundSubColor,
                ),
              ),
              const SizedBox(height: kPaddingMiddleSize),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: CustomTextButton(
                      onPressed: null,
                      text: 'Find ID / PW',
                    ),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  Expanded(
                    child: CustomTextButton(
                      onPressed: () => viewModel.navigateToSignupPage(context),
                      text: 'Create Account?',
                    ),
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
