import 'package:chrip_aid/auth/model/type/region/busan.dart';
import 'package:chrip_aid/auth/model/type/region/chungbuk.dart';
import 'package:chrip_aid/auth/model/type/region/chungnam.dart';
import 'package:chrip_aid/auth/model/type/region/daegu.dart';
import 'package:chrip_aid/auth/model/type/region/daejeon.dart';
import 'package:chrip_aid/auth/model/type/region/gangwon.dart';
import 'package:chrip_aid/auth/model/type/region/gwangju.dart';
import 'package:chrip_aid/auth/model/type/region/gyeongbuk.dart';
import 'package:chrip_aid/auth/model/type/region/gyeonggi.dart';
import 'package:chrip_aid/auth/model/type/region/gyeongnam.dart';
import 'package:chrip_aid/auth/model/type/region/incheon.dart';
import 'package:chrip_aid/auth/model/type/region/jeju.dart';
import 'package:chrip_aid/auth/model/type/region/jeonbuk.dart';
import 'package:chrip_aid/auth/model/type/region/jeonnam.dart';
import 'package:chrip_aid/auth/model/type/region/seoul.dart';
import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/auth/model/type/region/ulsan.dart';

enum MajorRegion {
  seoul("서울", "서울특별시", Seoul.values),
  busan("부산", "부산광역시", Busan.values),
  daegu("대구","대구광역시", Daegu.values),
  incheon("인천","인천광역시", Incheon.values),
  gwangju("광주","광주광역시", Gwangju.values),
  daejeon("대전","대전광역시", Daejeon.values),
  ulsan("울산","울산광역시", Ulsan.values),
  gyeonggi("경기","경기도", Gyeonggi.values),
  gangwon("강원","강원도", Gangwon.values),
  chungbuk("충북", "충청북도",Chungbuk.values),
  chungnam("충남", "충청남도",Chungnam.values),
  jeonbuk("전북","전라북도", Jeonbuk.values),
  jeonnam("전남", "전라남도", Jeonnam.values),
  gyeongbuk("경북", "경상북도",Gyeongbuk.values),
  gyeongnam("경남", "경상남도", Gyeongnam.values),
  jeju("제주","제주특별자치도", Jeju.values);

  final String name;
  final String fullName;
  final List<SubRegion> subTypes;

  const MajorRegion(this.name, this.fullName, this.subTypes);

  @override
  String toString() => name;

  factory MajorRegion.fromString(String value) {
    return MajorRegion.values.firstWhere((element) => element.name == value);
  }
}
