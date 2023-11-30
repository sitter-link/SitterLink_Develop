part of 'common_form_attributes.dart';

class MultiCheckboxFormAttributes extends CommonFormAttributes<List<String>> {
  final bool showBorder;
  final List<FormOptions> options;
  final bool isRequried;
  MultiCheckboxFormAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
    this.showBorder = true,
    this.isRequried = false,
    required this.options,
  });
}
