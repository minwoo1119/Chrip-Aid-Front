import 'package:chrip_aid/common/component/custom_image_picker.dart';
import 'package:chrip_aid/common/utils/aws_utils.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final orphanageEditInfoViewmodelProvider =
    Provider((ref) => OrphanageEditInfoViewmodel(ref));

class OrphanageEditInfoViewmodel {
  Ref ref;

  late final OrphanageManagementService _orphanageManagementService;

  final OrphanageDetailState orphanageDetailState = OrphanageDetailState();

  final MemberInfoState memberState = MemberInfoState();

  OrphanageDetailEntity? get _orphanage => orphanageDetailState.value;

  OrphanageMemberEntity? get _member =>
      memberState.value as OrphanageMemberEntity?;

  final TextEditingController orphanageNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  CustomImagePickerController imageController = CustomImagePickerController();

  OrphanageEditInfoViewmodel(this.ref) {
    _orphanageManagementService = ref.read(orphanageManagementServiceProvider);

    orphanageDetailState.addListener(() {
      if (orphanageDetailState.isSuccess) _initController();
    });
  }

  void getInfo() => orphanageDetailState
      .withResponse(_orphanageManagementService.getOrphanageInfo());

  void _initController() {
    orphanageNameController.text = _orphanage!.orphanageName;
    descriptionController.text = _orphanage!.description;
    addressController.text = _orphanage!.address;
    phoneNumberController.text = _orphanage!.phoneNumber;
    linkController.text = _orphanage!.homepageLink;
    // TODO : fix function (init image from orphanage detail entity)
  }

  void post(BuildContext context) async {
    final photoUrl = await uploadFileToS3(
      imageController.value.first,
      AwsS3Dir.orphanage,
    );
    if (photoUrl == null) return;
    await _orphanageManagementService.editOrphanageInfo(
      EditOrphanageInfoRequestDTO(
        orphanageId: _member!.orphanageId,
        orphanageName: orphanageNameController.text,
        address: addressController.text,
        homepageLink: linkController.text,
        description: descriptionController.text,
        photo: photoUrl,
        phoneNumber: phoneNumberController.text,
      ),
    );
    if (context.mounted) context.pop();
  }
}
