part of 'common_form_attributes.dart';

class TextFieldFormAttribute extends CommonFormAttributes<String> {
  final String hintText;
  final bool readOnly;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final int? maxLength;
  final int maxLines;
  final bool isRequired;
  final FormFieldValidator<String>? validator;
  final IconData? prefix;
  final IconData? suffix;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final double topPadding;
  final double bottomPadding;

  TextFieldFormAttribute({
    super.initialValue = "",
    required super.label,
    super.onChanged,
    required this.hintText,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.validator,
    this.prefix,
    this.suffix,
    String? fieldName,
    TextEditingController? controller,
    this.bottomPadding = 20,
    this.topPadding = 0,
  })  : controller = controller ?? TextEditingController(text: initialValue),
        super(fieldName: fieldName ?? label);
}
