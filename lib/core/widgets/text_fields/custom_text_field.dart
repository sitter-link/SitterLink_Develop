import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? textInputType;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final String fieldName;
  final bool obscureText;
  final bool readOnly;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isRequired;
  final VoidCallback? onPressed;
  final bool isFilled;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final VoidCallback? onEditCompleted;
  final Widget? prefix;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.topPadding = 0,
    this.bottomPadding = 20,
    this.rightPadding = 0,
    this.leftPadding = 0,
    this.obscureText = false,
    this.textInputType,
    this.readOnly = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.isRequired = false,
    this.onPressed,
    this.prefixIcon,
    this.isFilled = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    String? fieldName,
    this.inputFormatters,
    this.suffix,
    this.onEditCompleted,
    this.prefix,
  }) : fieldName = fieldName ?? label;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
        left: leftPadding,
        right: rightPadding,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            RichText(
              text: TextSpan(
                text: label,
                style: appTextTheme.formLabel,
                children: [
                  if (isRequired)
                    TextSpan(
                      text: " *",
                      style: appTextTheme.formLabel.copyWith(
                        color: Colors.red,
                      ),
                    )
                ],
              ),
            ),
          if (label.isNotEmpty) SizedBox(height: 12.hp),
          FormBuilderTextField(
            name: fieldName,
            style: appTextTheme.formInput,
            validator: validator,
            controller: controller,
            cursorColor: CustomTheme.primaryColor,
            maxLines: maxLines,
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            readOnly: readOnly,
            onTap: onPressed,
            maxLength: maxLength,
            onChanged:
                onChanged != null ? (val) => onChanged!(val ?? "") : null,
            onEditingComplete: () {
              if (onEditCompleted != null) {
                onEditCompleted!();
              }
              FocusScope.of(context).nextFocus();
            },
            onTapOutside: (event) {
              if (onEditCompleted != null) {
                onEditCompleted!();
              }
            },
            decoration: InputDecoration(
              border: getBorder(
                isFilled: isFilled,
              ),
              enabledBorder: getBorder(
                isFilled: isFilled,
              ),
              focusedBorder: getBorder(
                isFilled: isFilled,
              ),
              disabledBorder: getBorder(
                isFilled: isFilled,
              ),
              errorBorder: getBorder(
                isError: true,
                isFilled: isFilled,
              ),
              focusedErrorBorder: getBorder(
                isError: true,
                isFilled: isFilled,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              fillColor: readOnly
                  ? CustomTheme.grey.shade200.withOpacity(0.7)
                  : CustomTheme.backgroundColor,
              filled: readOnly || isFilled,
              counterText: "",
              hintText: hintText,
              hintStyle: appTextTheme.formInput.copyWith(
                color: CustomTheme.grey,
              ),
              prefixIcon: prefix ??
                  (prefixIcon != null
                      ? Icon(
                          prefixIcon,
                          size: 19,
                          color: CustomTheme.grey,
                        )
                      : null),
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: suffix ??
                  (suffixIcon != null
                      ? Icon(
                          suffixIcon,
                          size: 19,
                          color: CustomTheme.grey,
                        )
                      : null),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder getBorder({
    bool isError = false,
    required bool isFilled,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(CustomTheme.borderRadius),
      borderSide: BorderSide(
        color: isError
            ? Colors.red
            : (isFilled ? CustomTheme.backgroundColor : CustomTheme.grey.shade300),
      ),
    );
  }
}
