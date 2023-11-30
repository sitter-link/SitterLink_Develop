part of 'common_form_attributes.dart';

class CheckboxFormAttributes extends CommonFormAttributes<bool> {
  final bool showBorder;
  final AppFormController<bool>? controller;
  CheckboxFormAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
    this.controller,
    this.showBorder = true,
  });
}
