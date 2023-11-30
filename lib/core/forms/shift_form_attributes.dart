// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'common_form_attributes.dart';

class ShiftFormAttributes extends CommonFormAttributes<ShiftsState> {
  final bool showBorder;
  final bool isRequried;
  ShiftFormAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
    this.showBorder = true,
    this.isRequried = false,
  });
}

class ShiftsState {
  bool morning;
  bool afternoon;
  bool evening;
  bool night;

  ShiftsState({
    this.afternoon = false,
    this.evening = false,
    this.morning = false,
    this.night = false,
  });

  factory ShiftsState.fromMap(Map<String, dynamic> map) {
    return ShiftsState(
      morning: map[ShiftType.Morning.value],
      afternoon: map[ShiftType.Afternoon.value],
      evening: map[ShiftType.Evening.value],
      night: map[ShiftType.Night.value],
    );
  }

  ShiftsState copyWith({
    bool? morning,
    bool? afternoon,
    bool? evening,
    bool? night,
  }) {
    return ShiftsState(
      morning: morning ?? this.morning,
      afternoon: afternoon ?? this.afternoon,
      evening: evening ?? this.evening,
      night: night ?? this.night,
    );
  }

  Map<String, bool?> toMap() {
    return {
      ShiftType.Morning.value: morning,
      ShiftType.Afternoon.value: afternoon,
      ShiftType.Evening.value: evening,
      ShiftType.Night.value: night,
    };
  }
}
