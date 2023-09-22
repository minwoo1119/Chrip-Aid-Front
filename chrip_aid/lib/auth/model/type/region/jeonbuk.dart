import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Jeonbuk implements SubRegion {
  jeonjusi('전주시'),
  gunsansi('군산시'),
  iksansi('익산시'),
  jeongeubsi('정읍시'),
  namwonsi('남원시'),
  gimjesi("김제시");

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.jeonbuk;

  const Jeonbuk(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
