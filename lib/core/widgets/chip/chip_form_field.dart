import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/controllers/multi_select_form_controller.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/selectable_button.dart';

class ChipFormField extends StatefulWidget {
  final String fieldName;
  final String label;
  final bool isRequired;
  final ValueChanged? onChanged;
  final dynamic initialValue;
  final List<FormOptions> options;
  final double shortTitleHozPadding;
  final double defaultHosPadding;
  final MultiSelectFormController? controller;
  final bool showBorder;
  final bool readOnly;
  const ChipFormField({
    super.key,
    required this.label,
    String? fieldName,
    this.isRequired = false,
    this.onChanged,
    this.initialValue,
    required this.options,
    this.shortTitleHozPadding = 30,
    this.defaultHosPadding = 20,
    this.controller,
    this.showBorder = true,
    this.readOnly = false,
  }) : fieldName = fieldName ?? label;

  @override
  State<ChipFormField> createState() => _ChipFormFieldState();
}

class _ChipFormFieldState extends State<ChipFormField> {
  FormOptions? selectedOptions;

  List<FormOptions> options = [];
  late MultiSelectFormController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? MultiSelectFormController();
    controller.addListener(updateOptions);
    controller.value = [...widget.options];
    if (widget.initialValue != null) {
      try {
        selectedOptions =
            widget.options.singleWhere((e) => e.value == widget.initialValue);
      } catch (_) {}
    }
  }

  updateOptions() {
    setState(() {
      options = controller.value;
    });
  }

  @override
  void didUpdateWidget(covariant ChipFormField oldWidget) {
    if (oldWidget.options != widget.options) {
      controller.value = widget.options;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(updateOptions);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return AbsorbPointer(
      absorbing: widget.readOnly,
      child: FormBuilderField(
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
                contentPadding: EdgeInsets.only(bottom: 20.hp),
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
                  Wrap(
                    children: options
                        .map(
                          (e) => SelectableCard(
                            title: e.label,
                            isSelected: e.value == selectedOptions?.value,
                            defaultHozPadding: widget.defaultHosPadding,
                            shortTitleHozPadding: widget.shortTitleHozPadding,
                            onPressed: () {
                              field.didChange(e.value);
                              setState(() {
                                selectedOptions = e;
                              });
                              if (widget.onChanged != null) {
                                widget.onChanged!(e.value);
                              }
                            },
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            );
          }),
    );
  }
}
