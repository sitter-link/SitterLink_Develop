import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/others/custom_grid.dart';

class RadioCheckboxFormField extends StatefulWidget {
  final String label;
  final String fieldName;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final List<FormOptions> options;
  final bool isRequired;
  final bool showBorder;

  const RadioCheckboxFormField({
    super.key,
    required this.label,
    required this.fieldName,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    required this.options,
    this.showBorder = true,
  });

  @override
  State<RadioCheckboxFormField> createState() => _RadioCheckboxFormFieldState();
}

class _RadioCheckboxFormFieldState extends State<RadioCheckboxFormField> {
  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return FormBuilderField<String>(
      name: widget.fieldName,
      validator: (value) {
        if (value != null || !widget.isRequired) {
          return null;
        } else {
          return "${widget.label} field cannot be empty";
        }
      },
      initialValue: widget.initialValue,
      builder: (FormFieldState<dynamic> field) {
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
                childrens: widget.options.map((e) {
                  return InkWell(
                    onTap: () {
                      field.didChange(e.value);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0E5FF),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: field.value == e.value
                                    ? CustomTheme.primaryColor
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.wp),
                        Text(
                          e.label,
                          style: appTextTheme.bodyRegular,
                        ),
                      ],
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
