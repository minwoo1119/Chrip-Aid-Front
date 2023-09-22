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
import 'package:chrip_aid/auth/model/type/region/ulsan.dart';


enum Region<T> {
  seoul("서울", Seoul.values),
  busan("부산", Busan.values),
  daegu("대구", Daegu.values),
  incheon("인천", Incheon.values),
  gwangju("광주", Gwangju.values),
  daejeon("대전", Daejeon.values),
  ulsan("울산", Ulsan.values),
  gyeonggi("경기", Gyeonggi.values),
  gangwon("강원", Gangwon.values),
  chungbuk("충북", Chungbuk.values),
  chungnam("충남", Chungnam.values),
  jeonbuk("전북", Jeonbuk.values),
  jeonnam("전남", Jeonnam.values),
  gyeongbuk("경북", Gyeongbuk.values),
  gyeongnam("경남", Gyeongnam.values),
  jeju("제주", Jeju.values);

  final String value;
  final List<T> subTypes;

  const Region(this.value, this.subTypes);

  @override
  String toString() => value;
}
