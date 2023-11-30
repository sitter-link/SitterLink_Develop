// ignore_for_file: constant_identifier_names


enum JobCommitment {
  FullTime(label: "Full Time", value: "fulltime"),
  PartTime(label: "Part Time", value: "parttime");

  final String label;
  final String value;

  const JobCommitment({required this.label, required this.value});
}


