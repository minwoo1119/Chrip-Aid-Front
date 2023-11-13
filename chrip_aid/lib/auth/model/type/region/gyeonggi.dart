import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Gyeonggi implements SubRegion {
  suwonsi('수원시'),
  seongnamsi('성남시'),
  uijeongbusi('의정부시'),
  anyangsi('안양시'),
  bucheonsi('부천시'),
  gwangmyeongsi('광명시'),
  pyeongtaeksi('평택시'),
  dongducheonsi('동두천시'),
  ansansi('안산시'),
  goyangsi("고양시"),
  gwacheonsi("과천시"),
  gurisi("구리시"),
  namyangjusi("남양주시"),
  osansi("오산시"),
  siheungsi("시흥시"),
  gunposi("군포시"),
  uiwangsi("의왕시"),
  hanamsi('하남시'),
  yonginsi('용인시'),
  pajusi('파주시'),
  icheonsi('이천시'),
  anseongsi('안성시'),
  gimposi('김포시'),
  hwaseongsi('화성시'),
  gwangjusi('광주시'),
  yangjusi('양주시'),
  pocheonsi("포천시"),
  yeojusi("여주시");

  @override
  final String name;

  @override
  MajorRegion get majorRegion => MajorRegion.gyeonggi;

  const Gyeonggi(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
