part of 'common_form_attributes.dart';

class ImagePickerFormAttributes extends CommonFormAttributes<File> {
  final bool isRequired;
  final String imageUrl;
  ImagePickerFormAttributes({
    super.initialValue,
    this.imageUrl = "",
    required super.label,
    super.onChanged,
    required super.fieldName,
    this.isRequired = false,
  });
}
