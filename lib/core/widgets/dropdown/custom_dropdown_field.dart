import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class CustomDropDownField<Type> extends StatelessWidget {
  final String fieldName;
  final String label;
  final String hintText;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final List<FormOptions> options;
  final bool isRequired;
  final ValueChanged<Type>? onChanged;
  final Type? initialValue;
  final VoidCallback? onPressed;
  final bool readOnly;
  const CustomDropDownField({
    super.key,
    required this.label,
    required this.hintText,
    this.bottomPadding = 20,
    this.rightPadding = 0,
    this.leftPadding = 0,
    String? fieldName,
    this.isRequired = false,
    required this.options,
    this.onChanged,
    this.initialValue,
    this.onPressed,
    this.readOnly = false,
  }) : fieldName = fieldName ?? label;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomPadding.hp,
        left: leftPadding,
        right: rightPadding,
      ),
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
          FormBuilderDropdown<Type>(
            name: fieldName,
            initialValue: initialValue,
            onTap: onPressed,
            onChanged: (value) {
              if (value != null && onChanged != null) {
                onChanged!(value);
              }
            },
            style: appTextTheme.formInput,
            validator: isRequired
                ? (value) => FormValidator.validateFieldNotEmpty(
                      value?.toString(),
                      label,
                    )
                : null,
            enabled: !readOnly,
            decoration: InputDecoration(
              border: getBorder(),
              enabledBorder: getBorder(),
              focusedBorder: getBorder(),
              disabledBorder: getBorder(),
              errorBorder: getBorder(isError: true),
              focusedErrorBorder: getBorder(isError: true),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              fillColor:
                  readOnly ? CustomTheme.grey.shade300 : Colors.transparent,
              filled: readOnly,
              hintText: hintText,
              hintStyle: appTextTheme.formInput.copyWith(
                color: CustomTheme.grey,
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: CustomTheme.grey,
            ),
            items: options
                .map(
                  (e) => DropdownMenuItem<Type>(
                    value: e.value,
                    child: Text(
                      e.label,
                      style: appTextTheme.bodyRegular,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  InputBorder getBorder({
    bool isError = false,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: isError ? Colors.red : CustomTheme.grey,
      ),
    );
  }
}
