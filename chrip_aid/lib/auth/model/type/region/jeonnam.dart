import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Jeonnam implements SubRegion {
  mokposi('목포시'),
  yeosusi('여수시'),
  suncheonsi('순천시'),
  najusi('나주시'),
  gwangyangsi("광양시");

  @override
  final String name;

  @override
  MajorRegion get majorRegion => MajorRegion.jeonnam;

  const Jeonnam(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
