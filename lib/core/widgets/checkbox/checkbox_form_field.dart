import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/widgets/forms/app_form_controller.dart';

class CheckBoxFormField extends StatefulWidget {
  final String label;
  final String fieldName;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final bool showBorder;
  final AppFormController<bool>? controller;

  const CheckBoxFormField({
    super.key,
    required this.label,
    required this.fieldName,
    this.initialValue = false,
    this.onChanged,
    this.controller,
    this.showBorder = true,
  });

  @override
  State<CheckBoxFormField> createState() => _CheckBoxFormFieldState();
}

class _CheckBoxFormFieldState extends State<CheckBoxFormField> {
  final GlobalKey<FormBuilderFieldState> _formKey =
      GlobalKey<FormBuilderFieldState>();

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onChangedListener);
  }

  _onChangedListener() {
    _formKey.currentState?.didChange(widget.controller?.value);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onChangedListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomTheme.horizontalPadding,
        vertical: 12,
      ),
      constraints: const BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        border: Border(
          bottom: widget.showBorder
              ? BorderSide(color: CustomTheme.grey.shade300)
              : BorderSide.none,
        ),
      ),
      child: FormBuilderField<bool>(
          name: widget.fieldName,
          key: _formKey,
          initialValue: widget.initialValue,
          builder: (FormFieldState<bool> field) {
            return GestureDetector(
              onTap: () {
                if (widget.controller != null) {
                  widget.controller!.value = field.value ?? false;
                }
                field.didChange(!(field.value ?? false));
              },
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.375,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: field.value ?? false,
                      onChanged: (value) {
                        field.didChange(value);
                        if (widget.controller != null) {
                          widget.controller!.value = field.value ?? false;
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(value!);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
