import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:intl/intl.dart';

class Donate {
  final String orphanageName;
  final String date;
  final String productName;
  final int price;
  final int count;
  final String message;

  Donate({
    required this.orphanageName,
    required this.date,
    required this.productName,
    required this.price,
    required this.count,
    required this.message,
  });
}

class CustomDonateBox extends StatelessWidget {
  final String orphanageName;
  final String date;
  final String productName;
  final int price;
  final int count;
  final String message;

  const CustomDonateBox({
    super.key,
    required this.orphanageName,
    required this.date,
    required this.productName,
    required this.price,
    required this.count,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(date);
    const photo = 'assets/image/pajukids_house.jpg';
    final formattedDate = DateFormat('yyyy.M.d H:m').format(parsedDate);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
      margin: const EdgeInsets.only(bottom: 7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: kPaddingMiniSize),
                  child: Text(formattedDate,
                      style: kTextContentStyleSmall.copyWith(
                          color: CustomColor.textSubColor,
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 1.0),
                Row(
                  children: [
                    const SizedBox(width: 5.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                          image: const DecorationImage(
                            image: AssetImage(photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(orphanageName,
                                      style: kTextContentStyleMedium),
                                  Text('물품: $productName',
                                      style: kTextContentStyleSmall),
                                  Text(
                                      '$count개 ${NumberFormat.decimalPattern().format(price * count)}원',
                                      style: kTextPointStyleSmall),

                                  Text("남긴 메시지: $message",
                                      style: kTextContentStyleSmall),
                                  // Text(
                                  //   message,
                                  //   style: kTextContentStyleSmall
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
