import 'package:chrip_aid/auth/model/type/region.dart';

import 'sub_region.dart';

enum Ulsan implements SubRegion {
  junggu('중구'),
  namgu('남구'),
  donggu('동구'),
  bukgu('북구'),
  uljugun('울주군');

  @override
  final String name;

  @override
  MajorRegion get majorRegion => MajorRegion.ulsan;

  const Ulsan(this.name);

  @override
  String toJson() => "${majorRegion.name} ($name)";

  @override
  String toString() => name;
}
