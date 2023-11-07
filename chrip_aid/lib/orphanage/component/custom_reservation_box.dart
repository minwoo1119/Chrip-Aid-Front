import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/orphanage/component/reason_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomReservationBox extends StatelessWidget {
  final String orphanageName;
  final String writeDate;
  final String visitDate;
  final String reason;
  final String state;
  final String rejectReason;

  const CustomReservationBox({
    super.key,
    required this.orphanageName,
    required this.writeDate,
    required this.visitDate,
    required this.reason,
    required this.state,
    required this.rejectReason,
  });

  @override
  Widget build(BuildContext context) {
    final parsedWriteDate = DateTime.parse(writeDate);
    final formattedWriteDate =
        DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(parsedWriteDate);
    final parsedVisitDate = DateTime.parse(visitDate);
    final formattedVisitDate =
        DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(parsedVisitDate);

    return Container(
      decoration: BoxDecoration(
        color: CustomColor.backgroundMainColor,
        //borderRadius: BorderRadius.circular(kBorderRadiusSize),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.only(
        top: kPaddingSmallSize,
        left: kPaddingSmallSize,
        right: kPaddingSmallSize,
      ),
      padding: const EdgeInsets.all(kPaddingMiddleSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Text(orphanageName, style: kTextContentStyleMedium),
              ),
              Container(
                width: 110,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(
                    kBorderRadiusMiniSize,
                  ),
                  shape: BoxShape.rectangle,
                  //color: getStatusColor(state)
                ),
                child: Center(
                  child: Text(
                    getStatusText(state),
                    style: kTextContentStyleSmall,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kPaddingMiddleSize),
          Row(
            children: [
              const Text('방문 희망일', style: kTextDetailSubContentStyleSmall),
              const SizedBox(width: kPaddingMiddleSize),
              Text(formattedVisitDate, style: kTextDetailPointStyleSmall),
            ],
          ),
          Row(
            children: [
              const Text('방문 신청일', style: kTextDetailSubContentStyleSmall),
              const SizedBox(width: kPaddingMiddleSize),
              Text(formattedWriteDate, style: kTextDetailContentStyleSmall),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Divider(
              color: CustomColor.disabledColor,
              height: 2.0,
              thickness: 1.0,
            ),
          ),
          ReasonBox(reason: reason, title: "방문 사유"),
          state == "REJECTED"
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Divider(
                        color: CustomColor.disabledColor,
                        height: 2.0,
                        thickness: 1.0,
                      ),
                    ),
                    ReasonBox(reason: rejectReason, title: "거절 사유"),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

String getStatusText(String state) {
  if (state == 'APPROVED') {
    return "예약 승인";
  } else if (state == 'PENDING') {
    return "예약 대기";
  } else if (state == 'REJECTED') {
    return "예약 거절";
  } else {
    return "예약 종료";
  }
}

Color getStatusColor(String state) {
  if (state == 'APPROVED') {
    return const Color(0xFFB9E68C);
  } else if (state == 'PENDING') {
    return const Color(0xFFB0D6D3);
  } else if (state == 'REJECTED') {
    return const Color(0xFFFFD2D2);
  } else {
    return CustomColor.disabledColor;
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColor.backgroundMainColor,
          side: const BorderSide(color: CustomColor.disabledColor),
          elevation: 0,
        ),
        child: Text(
          label,
          style: kTextDetailContentStyleSmall,
        ),
      ),
    );
  }
}
