import 'package:chrip_aid/auth/model/type/region.dart';

abstract class SubRegion {
  MajorRegion get majorRegion;
  String get name;

  factory SubRegion.fromString(String value) {
    String major = value.split('(')[0].replaceAll(' ', '');
    String sub = value.split('(')[1].split(')')[0].replaceAll(' ', '');

    MajorRegion region = MajorRegion.fromString(major);
    return region.subTypes.firstWhere((element) => element.name == sub);
  }

  String toJson() => "${majorRegion.name} ($name)";
}