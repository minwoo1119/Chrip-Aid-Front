enum Jeonnam {
  mokposi('목포시'),
  yeosusi('여수시'),
  suncheonsi('순천시'),
  najusi('나주시'),
  gwangyangsi("광양시");

  final String value;

  const Jeonnam(this.value);

  @override
  String toString() => value;
}
