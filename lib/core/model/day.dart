import 'package:nanny_app/features/profile/enum/week_days.dart';

class Day {
  final int id;
  final String name;
  final String value;

  Day({required this.id, required this.name, required this.value});

  WeekDays get weekday => WeekDays.fromString(value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'day_name': name,
      'day_value': value,
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      id: map['id'],
      name: map['day_name'],
      value: map['day_value'],
    );
  }
}
