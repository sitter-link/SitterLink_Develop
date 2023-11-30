import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class MultiCheckboxFormField extends StatefulWidget {
  final String label;
  final String fieldName;
  final List<String> initialValue;
  final ValueChanged<List<String>>? onChanged;
  final List<FormOptions> options;
  final bool isRequired;
  final bool showBorder;

  const MultiCheckboxFormField({
    super.key,
    required this.label,
    required this.fieldName,
    this.initialValue = const [],
    this.onChanged,
    this.isRequired = false,
    required this.options,
    this.showBorder = true,
  });

  @override
  State<MultiCheckboxFormField> createState() => _MultiCheckboxFormFieldState();
}

class _MultiCheckboxFormFieldState extends State<MultiCheckboxFormField> {
  List<String> selectedOptions = [];

  @override
  void initState() {
    selectedOptions = [...widget.initialValue];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: EdgeInsets.only(bottom: 20.hp),
      child: FormBuilderField<List<String>>(
        name: widget.fieldName,
        validator: (value) {
          if (!widget.isRequired) {
            return null;
          } else if (value?.isEmpty ?? true && widget.isRequired) {
            return "${widget.label} field cannot be empty";
          } else {
            return null;
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
              contentPadding: const EdgeInsets.only(),
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
                SizedBox(height: 12.hp),
                Column(
                  children: widget.options.map((e) {
                    bool isSelected = selectedOptions.contains(e.value);
                    return Container(
                      padding: EdgeInsets.only(
                        bottom: widget.options.last.value != e.value ? 9.hp : 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 26,
                            width: 26,
                            child: Transform.scale(
                              scale: 0.85,
                              alignment: Alignment.centerLeft,
                              child: Checkbox(
                                value: isSelected,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (value) {
                                  if (isSelected) {
                                    selectedOptions.remove(e.value);
                                  } else {
                                    selectedOptions.add(e.value);
                                  }
                                  setState(() {});
                                  field.didChange(selectedOptions);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 6.wp),
                          InkWell(
                            onTap: () {
                              if (isSelected) {
                                selectedOptions.remove(e.value);
                              } else {
                                selectedOptions.add(e.value);
                              }
                              setState(() {});
                              field.didChange(selectedOptions);
                            },
                            child: Text(
                              e.label,
                              style: appTextTheme.bodyRegular,
                            ),
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
      ),
    );
  }
}
