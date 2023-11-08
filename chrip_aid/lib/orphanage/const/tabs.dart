import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:flutter/material.dart';

class TabInfo {
  final String label;
  final Color color;

  const TabInfo({required this.label, required this.color});
}

const TABS = [
  TabInfo(label: "물품 후원", color: Colors.white),
  TabInfo(label: "방문 신청", color: CustomColor.mainColor),
];

const tabReservation = [
  Tab(
    child: Text(
      '전체',
      style: TextStyle(fontSize: kTextMediumSize, fontWeight: FontWeight.bold),
    ),
  ),
  Tab(
    child: Text(
      '승인',
      style: TextStyle(fontSize: kTextMediumSize, fontWeight: FontWeight.bold),
    ),
  ),
  Tab(
    child: Text(
      '대기',
      style: TextStyle(fontSize: kTextMediumSize, fontWeight: FontWeight.bold),
    ),
  ),
  Tab(
    child: Text(
      '종료',
      style: TextStyle(fontSize: kTextMediumSize, fontWeight: FontWeight.bold),
    ),
  ),
];
