import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final String firstOption;
  final String secondOption;

  const CustomToggleButton({
    Key? key,
    required this.firstOption,
    required this.secondOption,
  }) : super(key: key);

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // 그림자 위치 조정
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 첫 번째 옵션 버튼
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected = true;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.green[300] : Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                widget.firstOption,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // 두 번째 옵션 버튼
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: !isSelected ? Colors.green[300] : Colors.white,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                widget.secondOption,
                style: TextStyle(
                  color: !isSelected ? Colors.white : Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

