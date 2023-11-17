import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:chrip_aid/common/layout/default_layout.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class CustomImagePicker extends ConsumerStatefulWidget {
  final CustomImagePickerController controller;

  const CustomImagePicker({Key? key, required this.controller})
      : super(key: key);

  @override
  ConsumerState<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends ConsumerState<CustomImagePicker> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (_, __, ___) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingSmallSize,
              vertical: kPaddingMiniSize,
            ).copyWith(bottom: kPaddingSmallSize),
            child: Row(
              children: [
                const Text("이미지", style: kTextSubContentStyleSmall),
                const Expanded(child: SizedBox()),
                if (widget.controller.value.isNotEmpty)
                  IconButton(
                    onPressed: widget.controller.removeImage,
                    icon: const Icon(
                      Icons.delete,
                      size: kIconSmallSize,
                    ),
                    splashRadius: kIconSmallSize,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                const SizedBox(width: kPaddingMiniSize),
                IconButton(
                  onPressed: widget.controller.pickImage,
                  icon: const Icon(Icons.add, size: kIconSmallSize),
                  splashRadius: kIconSmallSize,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: kPaddingSmallSize,
            ),
            height: 250,
            child: widget.controller.value.isEmpty
                ? IconButton(
                    onPressed: widget.controller.pickImage,
                    icon: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 75,
                      color: CustomColor.contentSubColor,
                    ),
                    splashRadius: 75,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )
                : _DesignedSwiper(
                    itemCount: widget.controller.value.length,
                    itemBuilder: (_, index) => InkWell(
                      onTap: () => showDialog(
                        useRootNavigator: true,
                        context: context,
                        builder: (context) => DefaultLayout(
                          extendBodyBehindAppBar: true,
                          appbarColor: Colors.transparent,
                          leading: IconButton(
                            onPressed: context.pop,
                            icon: const Icon(Icons.close),
                            color: CustomColor.textReverseColor,
                            splashRadius: kIconSmallSize,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          actions: [
                            IconButton(
                              onPressed: () {
                                widget.controller.removeImage();
                                context.pop();
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: kIconSmallSize,
                              ),
                              color: CustomColor.textReverseColor,
                              splashRadius: kIconSmallSize,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: kPaddingMiddleSize),
                          ],
                          title: "",
                          child: PhotoView(
                            imageProvider: FileImage(
                              widget.controller.value[index],
                            ),
                          ),
                        ),
                      ),
                      child: Image.file(
                        widget.controller.value[index],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    controller: widget.controller.swiperController,
                  ),
          )
        ],
      ),
    );
  }
}

class _DesignedSwiper extends Swiper {
  static const Color _color = CustomColor.textReverseColor;
  static const Color _disableColor = Color(0x55ffffff);

  const _DesignedSwiper({
    required super.itemCount,
    super.itemBuilder,
    super.controller,
  }) : super(
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              color: _disableColor,
              activeColor: _color,
            ),
          ),
          loop: false,
        );
}

class CustomImagePickerController extends ValueNotifier<List<File>> {
  SwiperController swiperController = SwiperController();
  final ImagePicker _imagePicker = ImagePicker();

  CustomImagePickerController() : super([]);

  void pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    value.add(File(image.path.toString()));
    notifyListeners();
  }

  void removeImage() async {
    value.removeAt(swiperController.index);
    notifyListeners();
  }
}
