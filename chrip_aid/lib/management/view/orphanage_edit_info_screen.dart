import 'package:chrip_aid/common/component/custom_image_picker.dart';
import 'package:chrip_aid/common/component/custom_outlined_button.dart';
import 'package:chrip_aid/common/component/custom_text_form_field.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/management/viewmodel/orphanage_edit_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrphanageEditInfoScreen extends ConsumerWidget {
  static String get routeName => "editOrphanage";

  const OrphanageEditInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(orphanageEditInfoViewmodelProvider)..getInfo();

    return DefaultLayout(
      title: "보육원 정보 수정",
      titleStyle: kTextContentStyleMedium,
      child: ValueStateListener(
        state: viewModel.orphanageDetailState,
        successBuilder: (_, state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingSmallSize),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        textController: viewModel.orphanageNameController,
                        fieldColor: CustomColor.backGroundSubColor,
                        backgroundColor: CustomColor.backGroundSubColor,
                        borderRadius: BorderRadius.zero,
                        inputBorder: const UnderlineInputBorder(),
                        labelText: "보육원 이름",
                        decorationStyle: kTextSubContentStyleSmall,
                        textStyle: kTextContentStyleMedium.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.only(
                          bottom: kPaddingMiniSize,
                        ),
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomTextFormField(
                        keyboardType: TextInputType.multiline,
                        textController: viewModel.descriptionController,
                        fieldColor: CustomColor.backGroundSubColor,
                        backgroundColor: CustomColor.backGroundSubColor,
                        borderRadius: BorderRadius.zero,
                        inputBorder: const OutlineInputBorder(),
                        labelText: "보육원 소개",
                        decorationStyle: kTextSubContentStyleSmall,
                        minLine: 8,
                        textStyle: kTextContentStyleMedium.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.all(kPaddingSmallSize),
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomTextFormField(
                        textController: viewModel.addressController,
                        fieldColor: CustomColor.backGroundSubColor,
                        backgroundColor: CustomColor.backGroundSubColor,
                        borderRadius: BorderRadius.zero,
                        inputBorder: const UnderlineInputBorder(),
                        labelText: "주소",
                        decorationStyle: kTextSubContentStyleSmall,
                        textStyle: kTextContentStyleMedium.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.only(
                          bottom: kPaddingMiniSize,
                        ),
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomTextFormField(
                        textController: viewModel.linkController,
                        fieldColor: CustomColor.backGroundSubColor,
                        backgroundColor: CustomColor.backGroundSubColor,
                        borderRadius: BorderRadius.zero,
                        inputBorder: const UnderlineInputBorder(),
                        labelText: "홈페이지 링크",
                        decorationStyle: kTextSubContentStyleSmall,
                        textStyle: kTextContentStyleMedium.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.only(
                          bottom: kPaddingMiniSize,
                        ),
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomTextFormField(
                        textController: viewModel.phoneNumberController,
                        fieldColor: CustomColor.backGroundSubColor,
                        backgroundColor: CustomColor.backGroundSubColor,
                        borderRadius: BorderRadius.zero,
                        inputBorder: const UnderlineInputBorder(),
                        labelText: "전화번호",
                        decorationStyle: kTextSubContentStyleSmall,
                        textStyle: kTextContentStyleMedium.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.only(
                          bottom: kPaddingMiniSize,
                        ),
                      ),
                      const SizedBox(height: kPaddingMiddleSize),
                      CustomImagePicker(
                        controller: viewModel.imageController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: kPaddingMiddleSize),
              CustomOutlinedButton(
                onPressed: () => viewModel.post(context),
                text: 'POST',
                textStyle: kTextReverseStyleMiddle,
              ),
              const SizedBox(height: kPaddingMiddleSize),
            ],
          ),
        ),
      ),
    );
  }
}
