enum Gyeongbuk {
  pohangsi('포항시'),
  gyeongjusi('경주시'),
  gimcheonsi('김천시'),
  andongsi('안동시'),
  gumisi("구미시"),
  yeongjusi("영주시"),
  yeongcheonsi("영천시"),
  sangjusi("상주시"),
  mungyeongsi("문경시"),
  gyeongsansi("경산시");

  final String value;

  const Gyeongbuk(this.value);

  @override
  String toString() => value;
}
