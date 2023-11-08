import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/common/utils/aws_utils.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/management/model/dto/edit_orphanage_info_request_dto.dart';
import 'package:chrip_aid/management/model/service/orphanage_management_service.dart';
import 'package:chrip_aid/management/model/state/orphanage_management_state.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/service/member_info_service.dart';
import 'package:chrip_aid/member/model/state/member_info_state.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

final orphanageEditInfoViewmodelProvider =
    ChangeNotifierProvider((ref) => OrphanageEditInfoViewmodel(ref));

class OrphanageEditInfoViewmodel extends ChangeNotifier {
  Ref ref;

  late OrphanageManagementState managementState;
  late MemberInfoState memberState;

  OrphanageDetailEntity? get orphanage => managementState is SuccessState
      ? (managementState as OrphanageManagementStateSuccess).data
      : null;

  OrphanageMemberEntity? get member => memberState is SuccessState
      ? (memberState as MemberInfoStateSuccess).data as OrphanageMemberEntity
      : null;

  final TextEditingController orphanageNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final SwiperController swiperController = SwiperController();

  final ImagePicker _imagePicker = ImagePicker();
  final List<File> images = [];

  OrphanageEditInfoViewmodel(this.ref) {
    managementState = ref.read(orphanageManagementServiceProvider);
    ref.listen(orphanageManagementServiceProvider, (previous, next) {
      if (previous != next) {
        managementState = next;
        if (managementState is ErrorState) {
          SnackBarUtil.showError((managementState as ErrorState).message);
        }
        if (managementState is SuccessState) _initController();
      }
    });
    memberState = ref.read(memberInfoServiceProvider);
    ref.listen(memberInfoServiceProvider, (previous, next) {
      if (previous != next) memberState = next;
    });
    _initController();
  }

  void _initController() {
    orphanageNameController.text = orphanage!.orphanageName;
    descriptionController.text = orphanage!.description;
    addressController.text = orphanage!.address;
    phoneNumberController.text = orphanage!.phoneNumber;
    linkController.text = orphanage!.homepageLink;
    // TODO : fix function (init image from orphanage detail entity)
  }

  void post(BuildContext context) async {
    final photoUrl = await uploadFileToS3(images.first, AwsS3Dir.orphanage);
    if(photoUrl == null) return;
    await ref.read(orphanageManagementServiceProvider.notifier).editOrphanageInfo(
          EditOrphanageInfoRequestDTO(
            orphanageId: member!.orphanageId,
            orphanageName: orphanageNameController.text,
            address: addressController.text,
            homepageLink: linkController.text,
            description: descriptionController.text,
            photo: photoUrl,
            phoneNumber: phoneNumberController.text,
          ),
        );
    context.pop();
  }

  void removeImage() async {
    images.removeAt(swiperController.index);
    notifyListeners();
  }

  void pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    images.add(File(image.path.toString()));
    notifyListeners();
  }
}
