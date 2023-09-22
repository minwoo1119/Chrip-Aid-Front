enum Busan {
  junggu('중구'),
  seogu('서구'),
  donggu('동구'),
  yeongdogu('영도구'),
  busanjingu('부산진구'),
  dongnaegu('동래구'),
  namgu('남구'),
  bukgu('북구'),
  haeundaegu('해운대구'),
  sahagu('사하구'),
  geumjeonggu('금정구'),
  gangseogu('강서구'),
  yeonjegu('연제구'),
  suyeongogu('수영구'),
  sasanggu('사상구'),
  gijanggun("기장군");

  final String value;

  const Busan(this.value);

  @override
  String toString() => value;
}
