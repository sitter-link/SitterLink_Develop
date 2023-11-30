class MultiCheckboxFilePickerOption<Type> {
  final Type value;
  final String booleanValueKey;
  final String label;
  final bool isRequired;

  const MultiCheckboxFilePickerOption({
    required this.value,
    required this.booleanValueKey,
    required this.label,
    this.isRequired=false,
  });
}
