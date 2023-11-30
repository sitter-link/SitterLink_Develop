// ignore_for_file: constant_identifier_names

enum ShiftType {
  Morning(label: "Morning", value: "morning"),
  Afternoon(label: "Afternoon", value: "afternoon"),
  Evening(label: "Evening", value: "evening"),
  Night(label: "Night", value: "night");

  final String label;
  final String value;

  const ShiftType({
    required this.label,
    required this.value,
  });

  factory ShiftType.fromString(String val) {
    if (val.toLowerCase() == ShiftType.Morning.value) {
      return ShiftType.Morning;
    } else if (val.toLowerCase() == ShiftType.Afternoon.value) {
      return ShiftType.Afternoon;
    } else if (val.toLowerCase() == ShiftType.Evening.value) {
      return ShiftType.Evening;
    } else if (val.toLowerCase() == ShiftType.Night.value) {
      return ShiftType.Night;
    } else {
      throw Exception("Invalid Shift Type");
    }
  }
}
