part of 'common_form_attributes.dart';

class MultiCheckboxFilePickerAttributes
    extends CommonFormAttributes<List<MultiCheckboxFile>> {
  final List<MultiCheckboxFilePickerOption> options;
  MultiCheckboxFilePickerAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
    required this.options,
  });
}

class MultiCheckboxFile {
  final String key;
  final String boolenValueKey;
  final File? file;

  MultiCheckboxFile({
    required this.key,
    required this.boolenValueKey,
    this.file,
  });

  MultiCheckboxFile copyWith({File? file}) {
    return MultiCheckboxFile(
      key: key,
      boolenValueKey: boolenValueKey,
      file: file,
    );
  }
}

extension MultiCheckboxFileExtension on List<MultiCheckboxFile> {
  int indexWithKey(String key) {
    final index = indexWhere((e) => e.key.toLowerCase() == key.toLowerCase());
    return index;
  }
}
