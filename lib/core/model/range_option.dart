class RangeOption {
  final int minYear;
  final int maxYear;

  RangeOption({
    required this.minYear,
    required this.maxYear,
  });

  String get value => "$minYear-$maxYear";
}
