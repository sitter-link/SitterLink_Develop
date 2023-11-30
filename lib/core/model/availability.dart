import 'package:nanny_app/core/enum/shift_type.dart';
import 'package:nanny_app/core/model/timeslot.dart';
import 'package:nanny_app/features/profile/enum/week_days.dart';

class Availability {
  final int id;
  final String name;
  final List<Timeslot> timeslots;

  Availability({
    required this.id,
    required this.name,
    required this.timeslots,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      "timeslots": timeslots.map((e) => e.toMap()).toList(),
    };
  }

  factory Availability.fromMap(Map<String, dynamic> map) {
    return Availability(
      id: map['id'],
      name: map['name'],
      timeslots: [],
    );
  }

  factory Availability.fromApiMap(Map<String, dynamic> map) {
    return Availability(
      id: map['day'],
      name: map['day_full_name'],
      timeslots: List.from(map['timeslots'] ?? [])
          .map((e) => Timeslot.fromMap(e))
          .toList(),
    );
  }

  WeekDays get weekday => WeekDays.fromString(name);
}

extension ListAvailabilityExtension on List<Availability> {
  bool checkWeekdaysAndShift(WeekDays weekday, ShiftType shift) {
    final index = indexWhere((e) => e.weekday == weekday);
    if (index != -1) {
      return this[index].timeslots.indexWhere((e) => e.shift == shift) != -1;
    } else {
      return false;
    }
  }

  Availability? findAvailabilityViaWeekDays(WeekDays weekday) {
    final index = indexWhere((e) => e.weekday == weekday);
    if (index != -1) {
      return this[index];
    } else {
      return null;
    }
  }
}
