class Language {
  final String code;
  final String name;

  Language({
    required this.code,
    required this.name,
  });

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      code: map["code"],
      name: map["name"],
    );
  }
}
