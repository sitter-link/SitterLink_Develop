class NannyFilterParam {
  final String? city;
  final num? minAge;
  final num? maxAge;
  final num? minExperience;
  final num? maxExperience;
  final String? language;
  final String? commitmentType;
  final List<String> exprienceWith;
  final Map<String, bool> requirements;
  final List<String> skills;
  final String query;

  NannyFilterParam({
    this.city,
    this.minAge,
    this.maxAge,
    this.minExperience,
    this.maxExperience,
    this.language,
    this.commitmentType,
    this.exprienceWith = const [],
    this.requirements = const {},
    this.skills = const [],
    this.query = "",
  });

  factory NannyFilterParam.fromFormData(Map<String, dynamic> map) {
    final List<String> ageRange = (map["age_between"] ?? "")
        .toString()
        .split("-")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final List<String> experienceRange = (map["experience"] ?? "")
        .toString()
        .split("-")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    return NannyFilterParam(
      city: map["city"],
      minAge: ageRange.isEmpty ? null : num.parse(ageRange.first),
      maxAge: ageRange.isEmpty ? null : num.parse(ageRange.last),
      commitmentType: map["commitment_type"]?.toString(),
      exprienceWith: List.from(map["experience_with"] ?? [])
          .map((e) => e.toString())
          .toList(),
      language: map["language"],
      minExperience:
          experienceRange.isEmpty ? null : num.parse(experienceRange.first),
      maxExperience:
          experienceRange.isEmpty ? null : num.parse(experienceRange.last),
      requirements: {
        for (String item
            in List.from(map["requirements"] ?? []).map((e) => e.toString()))
          item: true,
      },
      skills: List.from(map["skills"] ?? []).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> temp = {};
    if (commitmentType != null) {
      temp["commitment_type"] = [num.parse(commitmentType!)];
    }

    if (minAge != null) {
      temp["min_age"] = minAge;
    }

    if (maxAge != null) {
      temp["max_age"] = maxAge;
    }

    if (minExperience != null) {
      temp["min_experience"] = minExperience;
    }

    if (maxExperience != null) {
      temp["max_experience"] = maxExperience;
    }

    if (city != null) {
      temp["city"] = city;
    }

    if (language != null) {
      temp["language"] = language;
    }

    if (query.isNotEmpty) {
      temp["fullname"] = query;
    }

    if (skills.isNotEmpty) {
      temp["skills"] = skills.map((e) => num.parse(e)).toList();
    }

    if (exprienceWith.isNotEmpty) {
      temp["experiences_required"] =
          exprienceWith.map((e) => num.parse(e)).toList();
    }

    if (requirements.isNotEmpty) {
      temp.addEntries(
          requirements.entries.map((e) => MapEntry(e.key, true)).toList());
    }

    return temp;
  }

  NannyFilterParam copyWith({String? query, String? city}) {
    return NannyFilterParam(
      city: city ?? this.city,
      commitmentType: commitmentType,
      exprienceWith: exprienceWith,
      language: language,
      maxAge: maxAge,
      maxExperience: maxExperience,
      minAge: minAge,
      minExperience: minExperience,
      query: query ?? this.query,
      requirements: requirements,
      skills: skills,
    );
  }

  int get updateCount {
    int count = 0;
    if (city != null) {
      count++;
    }

    if (minAge != null && maxAge != null) {
      count++;
    }

    if (minExperience != null && maxExperience != null) {
      count++;
    }

    if (language != null) {
      count++;
    }

    if (commitmentType != null) {
      count++;
    }

    if (exprienceWith.isNotEmpty) {
      count++;
    }

    if (requirements.isNotEmpty) {
      count++;
    }

    if (skills.isNotEmpty) {
      count++;
    }

    return count;
  }
}
