part of 'common_form_attributes.dart';

class ChipFormAttribute<Type> extends CommonFormAttributes<Type?> {
  final List<FormOptions<Type>> options;
  final bool isRequired;
  final double shortTitleHozPadding;
  final double defaultHosPadding;
  final MultiSelectFormController? controller;
  final bool showBorder;
  final GlobalKey<FormBuilderFieldState>? key;
  final bool readOnly;
  ChipFormAttribute({
    this.key,
    super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
    this.isRequired = false,
    required this.options,
    this.shortTitleHozPadding = 30,
    this.defaultHosPadding = 20,
    this.controller,
    this.readOnly = false,
    this.showBorder = true,
  });
}
