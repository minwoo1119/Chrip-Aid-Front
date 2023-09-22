enum Daegu {
  junggu('중구'),
  donggu('동구'),
  seogu('서구'),
  namgu('남구'),
  bukgu('북구'),
  suseonggu('수성구'),
  dalseogu('달서구'),
  dalseonggun('달성군'),
  gunwgun('군위군');

  final String value;

  const Daegu(this.value);

  @override
  String toString() => value;
}