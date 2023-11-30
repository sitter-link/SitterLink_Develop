part of 'common_form_attributes.dart';

class RadioFormAttributes<Type> extends CommonFormAttributes<Type> {
  final List<FormOptions<Type>> options;
  final bool isRequired;
  final bool showBorder;
  RadioFormAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required this.options,
    required super.fieldName,
    required this.isRequired,
    this.showBorder = true,
  });
}
