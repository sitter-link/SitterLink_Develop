// ignore_for_file: constant_identifier_names

enum WeekDays {
  Sunday(label: "Sunday", value: "sunday", shortLabel: "SUN"),
  Monday(label: "Monday", value: "monday", shortLabel: "MON"),
  Tuesday(label: "Tuesday", value: "tuesday", shortLabel: "TUES"),
  Wednesday(label: "Wednesday", value: "wednesday", shortLabel: "WED"),

  Thursday(label: "Thursday", value: "thursday", shortLabel: "THU"),

  Friday(label: "Friday", value: "friday", shortLabel: "FRI"),
  Saturday(
    label: "Saturday",
    value: "saturday",
    shortLabel: "SAT",
  );

  final String label;
  final String value;
  final String shortLabel;

  const WeekDays({
    required this.label,
    required this.value,
    required this.shortLabel,
  });

  factory WeekDays.fromString(String val) {
    if (val.toLowerCase() == WeekDays.Sunday.value) {
      return WeekDays.Sunday;
    } else if (val.toLowerCase() == WeekDays.Monday.value) {
      return WeekDays.Monday;
    } else if (val.toLowerCase() == WeekDays.Tuesday.value) {
      return WeekDays.Tuesday;
    } else if (val.toLowerCase() == WeekDays.Wednesday.value) {
      return WeekDays.Wednesday;
    } else if (val.toLowerCase() == WeekDays.Thursday.value) {
      return WeekDays.Thursday;
    } else if (val.toLowerCase() == WeekDays.Friday.value) {
      return WeekDays.Friday;
    } else if (val.toLowerCase() == WeekDays.Saturday.value) {
      return WeekDays.Saturday;
    } else {
      throw Exception("Invalid weekdays");
    }
  }
}
