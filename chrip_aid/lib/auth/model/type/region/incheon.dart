enum Incheon {
  junggu('중구'),
  donggu('동구'),
  yeonsugu('미추홀구'),
  michuholgu('연수구'),
  namdonggu('남동구'),
  bupyeonggu('부평구'),
  gyeyanggu('계양구'),
  seogu('서구'),
  ganghwagun("강화군"),
  ongjingun("옹진군");

  final String value;

  const Incheon(this.value);

  @override
  String toString() => value;
}
