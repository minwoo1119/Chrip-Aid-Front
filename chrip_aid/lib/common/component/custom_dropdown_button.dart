import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropdownButton<T> extends ConsumerWidget {
  late final ChangeNotifierProvider<CustomDropdownButtonController<T>>
      _controller;
  final Color buttonColor;
  final Color boarderColor;
  final TextStyle textStyle;
  final IconData? leading;
  final IconData? action;

  CustomDropdownButton(
    CustomDropdownButtonController<T> controller, {
    Key? key,
    this.buttonColor = CustomColor.mainColor,
    this.boarderColor = CustomColor.mainColor,
    this.textStyle = kTextReverseStyleMiddle,
    this.leading,
    this.action,
  }) : super(key: key) {
    _controller = ChangeNotifierProvider((ref) => controller);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_controller);
    return DropdownButton<T>(
      itemHeight: 48.0,
      isExpanded: true,
      dropdownColor: buttonColor,
      icon: const SizedBox.shrink(),
      underline: const SizedBox.shrink(),
      items: controller.items
          .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.toString(),
                style: kTextReverseStyleMiddle,
              )))
          .toList(),
      onChanged: controller.onChanged,
      value: controller.selected,
      selectedItemBuilder: (context) => controller.items
          .map(
            (e) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadiusSize),
                border: Border.all(color: boarderColor, width: 3.0),
                color: buttonColor,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: kPaddingSmallSize,
              ),
              child: Row(
                children: [
                  if (leading != null) Icon(leading, color: textStyle.color),
                  const SizedBox(width: kPaddingSmallSize),
                  Expanded(
                    child: Text(
                      e.toString(),
                      style: kTextReverseStyleMiddle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: kPaddingSmallSize),
                  if (action != null) Icon(action, color: textStyle.color),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class CustomDropdownButtonController<T> extends ChangeNotifier {
  final List<T> items;
  late final void Function(T? value) onChanged;

  late T _selected;

  T get selected => _selected;

  CustomDropdownButtonController(
    this.items, {
    int initIndex = 0,
    Function(T value)? onChanged,
  }) : assert(initIndex < items.length && initIndex >= 0) {
    _selected = items[initIndex];
    this.onChanged = (T? value) {
      if (value == null) return;
      _selected = value;
      notifyListeners();
      if (onChanged != null) onChanged(value);
    };
  }
}
