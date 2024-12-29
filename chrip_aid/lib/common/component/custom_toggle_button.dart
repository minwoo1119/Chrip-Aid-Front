import 'package:flutter/material.dart';
import '../styles/colors.dart';

class CustomToggleButton extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int> onChanged;

  const CustomToggleButton({
    Key? key,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.options.length, (index) {
        bool isSelected = selectedIndex == index;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? CustomColor.buttonMainColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onChanged(index);
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Text(
                widget.options[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
