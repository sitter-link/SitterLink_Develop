part of 'common_form_attributes.dart';
class SwitchFormAttributes extends CommonFormAttributes<bool> {
  SwitchFormAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
  });
}
