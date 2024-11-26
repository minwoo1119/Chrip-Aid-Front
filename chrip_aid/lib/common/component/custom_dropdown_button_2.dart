import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropdownButton_2<T> extends ConsumerWidget {
  late final ChangeNotifierProvider<CustomDropdownButtonController_2<T>>
      _controller;
  final Color buttonColor;
  final Color boarderColor;
  final TextStyle textStyle;
  final IconData? leading;
  final IconData? action;
  final double itemHeight;

  CustomDropdownButton_2(
    CustomDropdownButtonController_2<T> controller, {
    Key? key,
    this.itemHeight = 48.0,
    this.buttonColor = Colors.white,
    this.boarderColor = const Color(0xFFD8D8D8),
    this.textStyle = kTextMainStyleMiddle,
    this.leading,
    this.action,
  }) : super(key: key) {
    _controller = ChangeNotifierProvider((ref) => controller);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_controller);
    return DropdownButton<T>(
      itemHeight: itemHeight,
      isExpanded: true,
      dropdownColor: buttonColor,
      icon: const SizedBox.shrink(),
      underline: const SizedBox.shrink(),
      items: controller.items
          .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.toString(),
                style: textStyle,
              )))
          .toList(),
      onChanged: controller.onChanged,
      value: controller.selected,
      selectedItemBuilder: (context) => controller.items
          .map((e) => CustomDropdownButtonItem(
                e.toString(),
                buttonColor: buttonColor,
                boarderColor: boarderColor,
                textStyle: textStyle,
                leading: leading,
                action: action,
                itemHeight: itemHeight,
              ))
          .toList(),
    );
  }
}

class CustomDropdownButtonItem extends StatelessWidget {
  final Color buttonColor;
  final Color boarderColor;
  final TextStyle textStyle;
  final IconData? leading;
  final IconData? action;
  final double itemHeight;
  final String text;

  const CustomDropdownButtonItem(
    this.text, {
    Key? key,
    this.buttonColor = Colors.white,
    this.boarderColor = const Color(0xFFD8D8D8),
    this.textStyle = kTextReverseStyleMiddle,
    this.itemHeight = 48.0,
    this.leading,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
        border: Border.all(color: boarderColor, width: 1.0),
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
              text,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: kPaddingSmallSize),
          if (action != null) Icon(action, color: textStyle.color),
        ],
      ),
    );
  }
}

class CustomDropdownButtonController_2<T> extends ChangeNotifier {
  List<T> _items;

  List<T> get items => _items;

  set items(List<T> items) {
    _items = items;
    _selected = _items[0];
    notifyListeners();
  }

  late final void Function(T? value) onChanged;

  late T _selected;

  T get selected => _selected;

  CustomDropdownButtonController_2(
    this._items, {
    int initIndex = 0,
    Function(T value)? onChanged,
  }) : assert(initIndex < _items.length && initIndex >= 0) {
    _selected = _items[initIndex];
    this.onChanged = (T? value) {
      if (value == null) return;
      _selected = value;
      notifyListeners();
      if (onChanged != null) onChanged(value);
    };
  }

  void select(int index) {
    onChanged(_items[index]);
  }
}
