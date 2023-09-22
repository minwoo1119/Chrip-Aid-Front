enum Chungnam {
  cheonansi('천안시'),
  gongjusi('공주시'),
  boreungsi('보령시'),
  asansi('아산시'),
  seosansi('서산시'),
  nonsansi('논산시'),
  gyeryongsi('계룡시'),
  dangjinsi("당진시");

  final String value;

  const Chungnam(this.value);

  @override
  String toString() => value;
}
