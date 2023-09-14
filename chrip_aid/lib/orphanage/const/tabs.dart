import 'package:chrip_aid/common/styles/colors.dart';
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
