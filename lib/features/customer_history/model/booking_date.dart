import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/model/timeslot.dart';

class BookingDate {
  final DateTime date;
  final List<Timeslot> timeslots;

  const BookingDate({
    required this.date,
    required this.timeslots,
  });

  BookingDate copyWith({
    DateTime? date,
    List<Timeslot>? timeslots,
  }) {
    return BookingDate(
      date: date ?? this.date,
      timeslots: timeslots ?? this.timeslots,
    );
  }

  factory BookingDate.fromMap(Map<String, dynamic> map) {
    return BookingDate(
      date: Jiffy.parse(map['date']).dateTime,
      timeslots: List.from(map['time_slots'])
          .map<Timeslot>(
            (x) => Timeslot.fromMap(x),
          )
          .toList(),
    );
  }
}
