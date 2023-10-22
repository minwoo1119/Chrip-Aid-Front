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

  const CustomReservationBox(
      {super.key,
      required this.orphanageName,
      required this.writeDate,
      required this.visitDate,
      required this.reason,
      required this.state,
      required this.rejectReason});

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
      padding: const EdgeInsets.symmetric(
          // horizontal: kPaddingMiniMiniSize,
          vertical: kPaddingMiniMiniSize),
      margin: const EdgeInsets.only(
          top: 7, left: kPaddingSmallSize, right: kPaddingSmallSize),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: kPaddingMiniMiniSize),
                      Row(children: [
                        const SizedBox(width: kPaddingMiniSize),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(kPaddingMiddleSize),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(orphanageName,
                                          style: kTextContentStyleMedium),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 110,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kBorderRadiusMiniSize),
                                              shape: BoxShape.rectangle,
                                              //color: getStatusColor(state)
                                            ),
                                            child: Center(
                                                child: state == 'APPROVED'
                                                    ? const Text("예약 승인",
                                                        style:
                                                            kTextContentStyleSmall)
                                                    : state == 'PENDING'
                                                        ? const Text("예약 대기",
                                                            style:
                                                                kTextContentStyleSmall)
                                                        : state == 'REJECTED'
                                                            ? const Text(
                                                                "예약 거절",
                                                                style:
                                                                    kTextContentStyleSmall)
                                                            : const Text(
                                                                "방문 완료",
                                                                style:
                                                                    kTextContentStyleSmall)),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                  const SizedBox(height: kPaddingMiddleSize),
                                  Row(
                                    children: [
                                      const Text('방문 희망일      ',
                                          style:
                                              kTextDetailSubContentStyleSmall),
                                      Text(formattedVisitDate,
                                          style: kTextDetailPointStyleSmall),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('방문 신청일      ',
                                          style:
                                              kTextDetailSubContentStyleSmall),
                                      Text(formattedWriteDate,
                                          style: kTextDetailContentStyleSmall),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: const Divider(
                                                color:
                                                    CustomColor.disabledColor,
                                                height: 2.0,
                                                thickness: 1.0,
                                              ),
                                            ),
                                            ReasonBox(
                                                reason: rejectReason,
                                                title: "거절 사유"),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ]),
              )
            ],
          ),
        ],
      ),
    );
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
