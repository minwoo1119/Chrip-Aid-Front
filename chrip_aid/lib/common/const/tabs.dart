import 'package:chrip_aid/root_tab/view/tab_screen.dart';
import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;
  final Widget tab;

  const TabInfo(this.tab, {required this.icon, required this.label});
}
