import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class CustomDateTimeField extends StatelessWidget {
  final String fieldName;
  final String label;
  final String hintText;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final bool isRequired;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? initialValue;
  final InputType dateTimeInputType;
  final bool readOnly;
  final DateTime? maxDate;
  final DateTime? minDate;
  final DateTime? currentDate;
  const CustomDateTimeField({
    super.key,
    required this.label,
    required this.hintText,
    this.bottomPadding = 16,
    this.rightPadding = 0,
    this.leftPadding = 0,
    String? fieldName,
    this.isRequired = false,
    this.onChanged,
    this.initialValue,
    this.readOnly = false,
    this.dateTimeInputType = InputType.date,
    this.currentDate,
    this.maxDate,
    this.minDate,
  }) : fieldName = fieldName ?? label;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomPadding,
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
          if (label.isNotEmpty) SizedBox(height: 6.hp),
          FormBuilderDateTimePicker(
            name: fieldName,
            firstDate: minDate,
            initialValue: initialValue,
            onChanged: (value) {
              if (value != null && onChanged != null) {
                onChanged!(value);
              }
            },
            inputType: dateTimeInputType,
            style: appTextTheme.formInput,
            format: DateFormat("yyyy-MM-dd"),
            initialDate:
                (maxDate?.isBefore(DateTime.now()) ?? false) ? maxDate : null,
            lastDate: maxDate,
            enabled: !readOnly,
            validator: isRequired
                ? (value) => FormValidator.validateFieldNotEmpty(
                      value?.toString(),
                      label,
                    )
                : null,
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
              suffixIcon: Icon(
                CupertinoIcons.calendar,
                size: 19,
                color: CustomTheme.grey,
              ),
              hintText: hintText,
              hintStyle: appTextTheme.formInput.copyWith(
                color: CustomTheme.grey,
              ),
            ),
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
