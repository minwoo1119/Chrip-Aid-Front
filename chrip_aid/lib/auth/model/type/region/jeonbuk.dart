enum Jeonbuk {
  jeonjusi('전주시'),
  gunsansi('군산시'),
  iksansi('익산시'),
  jeongeubsi('정읍시'),
  namwonsi('남원시'),
  gimjesi("김제시");

  final String value;

  const Jeonbuk(this.value);

  @override
  String toString() => value;
}
