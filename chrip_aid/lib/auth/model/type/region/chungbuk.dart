import 'package:chrip_aid/auth/model/type/region.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';

enum Chungbuk implements SubRegion {
  cheongjusi('청주시'),
  chungjusi('충주시'),
  jecheonsi('제천시');

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.chungbuk;

  const Chungbuk(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
