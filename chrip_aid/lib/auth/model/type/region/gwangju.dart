enum Gwangju {
  donggu('동구'),
  seogu('서구'),
  namgu('남구'),
  bukgu('북구'),
  gwangsangu('광산구');

  final String value;

  const Gwangju(this.value);

  @override
  String toString() => value;
}
