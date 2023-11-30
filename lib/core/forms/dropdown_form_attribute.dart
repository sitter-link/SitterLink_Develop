part of 'common_form_attributes.dart';
class DropDownFormAttribute<Type> extends CommonFormAttributes<Type?> {
  final List<FormOptions> options;
  final String hintText;
  final VoidCallback? onPressed;
  final bool isRequired;
  final bool readOnly;
  DropDownFormAttribute({
    Type? initialValue,
    required super.label,
    required this.options,
    super.onChanged,
    required this.hintText,
    this.onPressed,
    this.isRequired = false,
    this.readOnly = false,
    String? fieldName,
  }) : super(fieldName: fieldName ?? label, initialValue: initialValue);
}
