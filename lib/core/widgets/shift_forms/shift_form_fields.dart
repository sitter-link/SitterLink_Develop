import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/enum/shift_type.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/others/custom_grid.dart';

class ShiftFormField extends StatefulWidget {
  final String label;
  final String fieldName;
  final ShiftsState? initialValue;
  final ValueChanged<ShiftsState>? onChanged;
  final bool isRequired;
  final bool showBorder;

  const ShiftFormField({
    super.key,
    required this.label,
    required this.fieldName,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.showBorder = true,
  });

  @override
  State<ShiftFormField> createState() => _ShiftFormFieldState();
}

class _ShiftFormFieldState extends State<ShiftFormField> {
  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return FormBuilderField<Map<String, bool?>>(
      name: widget.fieldName,
      validator: (value) {
        if (value != null || !widget.isRequired) {
          return null;
        } else {
          return "${widget.label} field cannot be empty";
        }
      },
      initialValue: widget.initialValue?.toMap(),
      builder: (FormFieldState<Map<String, bool?>> field) {
        return InputDecorator(
          decoration: InputDecoration(
            errorText: field.errorText,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(
              bottom: 20.hp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label.isNotEmpty)
                RichText(
                  text: TextSpan(
                    text: widget.label,
                    style: appTextTheme.formLabel,
                    children: [
                      if (widget.isRequired)
                        TextSpan(
                          text: " *",
                          style: appTextTheme.formLabel.copyWith(
                            color: Colors.red,
                          ),
                        )
                    ],
                  ),
                ),
              SizedBox(height: 18.hp),
              CustomGridWidget(
                mainAxisSpacing: 16,
                childrens: ShiftType.values.map((e) {
                  return InkWell(
                    onTap: () {
                      final Map<String, bool?> updatedState = {
                        ...?field.value,
                        e.value: switch (field.value?[e.value]) {
                          true => false,
                          false => true,
                          _ => true,
                        }
                      };
                      field.didChange(updatedState);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: switch (field.value?[e.value]) {
                            true => CustomTheme.primaryColor,
                            _ => CustomTheme.grey,
                          },
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.label,
                            style: appTextTheme.bodyRegular.copyWith(
                              color: switch (field.value?[e.value]) {
                                true => CustomTheme.primaryColor,
                                _ => CustomTheme.grey,
                              },
                            ),
                          ),
                          SizedBox(width: 8.wp),
                          switch (field.value?[e.value]) {
                            true => Container(
                                height: 16,
                                width: 16,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFEEECFF),
                                ),
                              ),
                            _ => Container(),
                          }
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
