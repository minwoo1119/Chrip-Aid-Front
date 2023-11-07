import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/orphanage/model/dto/add_orphanage_product_request_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

final orphanageEditProductViewModelProvider =
ChangeNotifierProvider((ref) => OrphanageEditProductViewModel(ref));

class OrphanageEditProductViewModel extends ChangeNotifier {
  Ref ref;

  final ImagePicker _imagePicker = ImagePicker();
  final List<File> images = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  SwiperController swiperController = SwiperController();

  OrphanageEditProductViewModel(this.ref);

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

  void post(BuildContext context) {
    context.pop();
  }
}
