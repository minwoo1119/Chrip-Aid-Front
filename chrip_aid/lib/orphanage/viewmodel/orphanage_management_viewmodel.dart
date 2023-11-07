import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/dto/orphanage_product_add_request_dto.dart';
import 'package:chrip_aid/orphanage/view/orphanage_edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageManagementViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageEditViewModel(ref));

class OrphanageEditViewModel extends ChangeNotifier {
  Ref ref;

  late MemberInfoState state;

  OrphanageDetailEntity get entity =>
      ((state as MemberInfoStateSuccess).data as OrphanageMemberEntity)
          .orphanage;

  OrphanageEditViewModel(this.ref) {
    state = ref.read(memberInfoServiceProvider);
    ref.listen(memberInfoServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }

  void navigateToAddProductScreen(
    BuildContext context, {
    OrphanageProductAddRequestDTO? entity,
  }) {
    context.pushNamed(OrphanageEditProductScreen.routeName, extra: entity);
  }
}
