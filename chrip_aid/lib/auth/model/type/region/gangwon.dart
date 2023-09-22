import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Gangwon implements SubRegion {
  chuncheonsi('춘천시'),
  wonjusi('원주시'),
  gangneungsi('강릉시'),
  donghaesi('동해시'),
  taebaeksi('태백시'),
  sokchosi('속초시'),
  samcheoksi('삼척시');

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.gangwon;

  const Gangwon(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
