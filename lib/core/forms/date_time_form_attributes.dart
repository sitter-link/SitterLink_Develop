
part of 'common_form_attributes.dart';
class DateTimeFormAttribute<Type> extends CommonFormAttributes<Type?> {
  final String hintText;
  final bool isRequired;
  final InputType type;
  final bool readOnly;
  final DateTime? maxDate;
  final DateTime? minDate;
  final DateTime? currentDate;
  DateTimeFormAttribute({
    Type? initialValue,
    required super.label,
    super.onChanged,
    required this.hintText,
    this.isRequired = false,
    String? fieldName,
    this.readOnly = false,
    this.type = InputType.date,
    this.minDate,
    this.maxDate,
    this.currentDate,
  })  : assert(currentDate != null && maxDate != null
            ? maxDate.isAfter(currentDate)
            : true),
        super(fieldName: fieldName ?? label, initialValue: initialValue);
}
