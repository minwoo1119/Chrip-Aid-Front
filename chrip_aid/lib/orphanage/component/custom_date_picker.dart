import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class OrphanageDateForm extends StatefulWidget {
  final String title;
  final IconData iconData;
  final TextEditingController controller;
  final EdgeInsetsGeometry margin;
  final Function(DateTime)? onDateSelected; // 선택한 날짜를 전달할 콜백 함수

  const OrphanageDateForm({
    Key? key,
    required this.title,
    required this.iconData,
    required this.controller,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
    this.onDateSelected,
  }) : super(key: key);

  @override
  OrphanageDateFormState createState() => OrphanageDateFormState();
}

class OrphanageDateFormState extends State<OrphanageDateForm> {
  DateTime? selectedDate ;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    _focusNode.unfocus();
    DateTime? initialDate = selectedDate ?? DateTime.now();

    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext builderContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: DateTime(2000),
                maximumDate: DateTime(2101),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
            ),
            InkWell(
              onTap: () {
                print(selectedDate);
                if (widget.onDateSelected != null && selectedDate != null) {
                  widget.onDateSelected!(selectedDate!);
                }
                widget.controller.text =
                    DateFormat('yyyy년 MM월 dd일').format(selectedDate!);
                print(widget.controller.text);
                print(selectedDate);
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        //widget.controller.text = selectedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                widget.iconData,
                size: kTextSmallSize,
                color: CustomColor.mainColor,
              ),
              const SizedBox(width: 5.0),
              GestureDetector(
                onTap: () => _selectDate(context),
                // 힌트 텍스트 라인 클릭 시 _selectDate 호출
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: kTextXSmallSize,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.mainColor,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => _selectDate(context),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0), // 버튼의 패딩 설정
                  child: Text(
                    selectedDate != null
                        ? DateFormat('yyyy년 MM월 dd일').format(selectedDate!)
                        : widget.controller.text,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.mainColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
