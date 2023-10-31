import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final orphanageEditPostsViewModelProvider =
    ChangeNotifierProvider((ref) => OrphanageEditPostsViewModel(ref));

class OrphanageEditPostsViewModel extends ChangeNotifier {
  Ref ref;

  final ImagePicker _imagePicker = ImagePicker();
  final List<File> images = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  SwiperController controller = SwiperController();

  OrphanageEditPostsViewModel(this.ref);

  void removeImage() async {
    images.removeAt(controller.index);
    notifyListeners();
  }

  void pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image == null) return;
    images.add(File(image.path.toString()));
    notifyListeners();
  }

  void post() {}
}
