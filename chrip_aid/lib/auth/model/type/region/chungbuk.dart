import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';

enum Chungbuk implements SubRegion {
  cheongjusi('청주시'),
  chungjusi('충주시'),
  jecheonsi('제천시');

  @override
  final String name;

  @override
  MajorRegion get majorRegion => MajorRegion.chungbuk;

  const Chungbuk(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
