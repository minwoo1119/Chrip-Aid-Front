import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/member/model/dto/edit_orphanage_member_info_request_dto.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final editOrphanageMemberInfoViewModelProvider =
    ChangeNotifierProvider((ref) => EditUserInfoViewModel(ref));

class EditUserInfoViewModel extends ChangeNotifier {
  final Ref ref;

  late final TextEditingController nameTextController;
  late final TextEditingController passwordTextController;
  late final TextEditingController checkPasswordTextController;

  late MemberInfoState userInfoState;

  OrphanageMemberEntity? get userInfo => userInfoState is MemberInfoStateSuccess
      ? (userInfoState as MemberInfoStateSuccess).data as OrphanageMemberEntity
      : null;

  EditUserInfoViewModel(this.ref) {
    userInfoState = ref.read(memberInfoServiceProvider);
    ref.listen(memberInfoServiceProvider, (previous, next) {
      if (previous != next) userInfoState = next;
    });

    nameTextController = TextEditingController(text: userInfo!.name);
    passwordTextController = TextEditingController();
    checkPasswordTextController = TextEditingController();
  }

  void editUserInfo(BuildContext context) async {
    if(passwordTextController.text != checkPasswordTextController.text) {
      return SnackBarUtil.showError("비밀번호가 일치하지 않습니다.");
    }
    await ref.read(memberInfoServiceProvider.notifier).editMemberInfo(
          EditOrphanageMemberInfoRequestDto(
            name: nameTextController.text,
            password: passwordTextController.text,
          ),
        );
    if (context.mounted) context.pop();
  }
}
