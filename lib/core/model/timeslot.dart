import 'package:nanny_app/core/enum/shift_type.dart';

class Timeslot {
  int id;
  String name;
  String timeslotValue;
  String slug;

  Timeslot({
    required this.id,
    required this.name,
    required this.timeslotValue,
    required this.slug,
  });

  Timeslot copyWith({
    int? id,
    String? name,
    String? timeslotValue,
    String? slug,
  }) {
    return Timeslot(
      id: id ?? this.id,
      name: name ?? this.name,
      timeslotValue: timeslotValue ?? this.timeslotValue,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'timeslotValue': timeslotValue,
      'slug': slug,
    };
  }

  factory Timeslot.fromMap(Map<String, dynamic> map) {
    return Timeslot(
      id: map['id'],
      name: map['name'] ?? "",
      timeslotValue: map['timeslotValue'] ?? map['timeslot_value'] ?? "",
      slug: map['slug'] ?? "",
    );
  }

  ShiftType get shift => ShiftType.fromString(slug);
}
