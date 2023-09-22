import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Chungnam implements SubRegion {
  cheonansi('천안시'),
  gongjusi('공주시'),
  boreungsi('보령시'),
  asansi('아산시'),
  seosansi('서산시'),
  nonsansi('논산시'),
  gyeryongsi('계룡시'),
  dangjinsi("당진시");

  @override
  final String value;

  @override
  MajorRegion get majorRegion => MajorRegion.chungnam;

  const Chungnam(this.value);

  @override
  String toJson() => "${majorRegion.value} ($value)";

  @override
  String toString() => value;
}
