import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/file_picker_utils.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/dotted_button.dart';
import 'package:nanny_app/core/widgets/image_pickers/multi_checkbox_file_picker_option.dart';
import 'package:nanny_app/features/profile/widgets/nanny_profile_information_professional_tabview.dart';

class MultiCheckboxFilePickerFormField extends StatefulWidget {
  final String label;
  final String fieldName;
  final List<MultiCheckboxFile> initialValue;
  final ValueChanged<List<MultiCheckboxFile>>? onChanged;
  final List<MultiCheckboxFilePickerOption> options;

  const MultiCheckboxFilePickerFormField({
    super.key,
    required this.label,
    required this.fieldName,
    this.initialValue = const [],
    this.onChanged,
    required this.options,
  });

  @override
  State<MultiCheckboxFilePickerFormField> createState() =>
      _MultiCheckboxFilePickerFormFieldState();
}

class _MultiCheckboxFilePickerFormFieldState
    extends State<MultiCheckboxFilePickerFormField> {
  List<MultiCheckboxFile> selectedOptions = [];

  @override
  void initState() {
    selectedOptions = [
      ...widget.initialValue,
      ...widget.options
          .where((e) => e.isRequired)
          .map((e) => MultiCheckboxFile(
              key: e.value, boolenValueKey: e.booleanValueKey))
          .toList()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: EdgeInsets.only(
        bottom: 20.hp,
      ),
      child: FormBuilderField<List<MultiCheckboxFile>>(
        name: widget.fieldName,
        validator: (value) {
          if (value?.every((e) => e.file != null) ?? false) {
            return null;
          } else {
            return "Checked field file cannot be empty";
          }
        },
        initialValue: selectedOptions,
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
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.label.isNotEmpty)
                  RichText(
                    text: TextSpan(
                      text: widget.label,
                      style: appTextTheme.formLabel,
                    ),
                  ),
                SizedBox(height: 12.hp),
                Column(
                  children: widget.options.map((e) {
                    final int selectedIndex =
                        selectedOptions.indexWithKey(e.value);
                    bool isSelected = selectedIndex != -1;
                    return Container(
                      padding: EdgeInsets.only(
                        bottom: widget.options.last.value != e.value ? 9.hp : 0,
                      ),
                      child: Column(
                        children: [
                          AbsorbPointer(
                            absorbing: e.isRequired,
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
                                          selectedOptions.removeWhere(
                                              (element) =>
                                                  element.key == e.value);
                                        } else {
                                          selectedOptions.add(MultiCheckboxFile(
                                            key: e.value,
                                            boolenValueKey: e.booleanValueKey,
                                          ));
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
                                      selectedOptions.removeWhere(
                                          (element) => element.key == e.value);
                                    } else {
                                      selectedOptions.add(MultiCheckboxFile(
                                        key: e.value,
                                        boolenValueKey: e.booleanValueKey,
                                      ));
                                    }
                                    setState(() {});
                                    field.didChange(selectedOptions);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: e.label,
                                      style: appTextTheme.bodyRegular,
                                      children: [
                                        if (e.isRequired)
                                          TextSpan(
                                            text: " *",
                                            style: TextStyle(
                                              color: CustomTheme.red,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected) SizedBox(height: 12.hp),
                          if (isSelected)
                            switch (selectedOptions[selectedIndex].file) {
                              null => DottedButton(
                                  title: "Add File",
                                  borderRadius: 8,
                                  iconData: CupertinoIcons.add,
                                  isIconCentered: true,
                                  textColor: CustomTheme.textColor,
                                  iconColor: CustomTheme.textColor,
                                  fontWeight: FontWeight.w400,
                                  onPressed: () async {
                                    final res =
                                        await FilePickerUtils.pickFile();
                                    if (res != null) {
                                      selectedOptions[selectedIndex] =
                                          selectedOptions[selectedIndex]
                                              .copyWith(
                                        file: res,
                                      );
                                      setState(() {});
                                      field.didChange(selectedOptions);
                                    }
                                  },
                                ),
                              _ => PdfUploadButton(
                                  text: selectedOptions[selectedIndex]
                                      .file!
                                      .fileName,
                                  onClosed: () {
                                    selectedOptions[selectedIndex] =
                                        MultiCheckboxFile(
                                      boolenValueKey:
                                          selectedOptions[selectedIndex]
                                              .boolenValueKey,
                                      key: selectedOptions[selectedIndex].key,
                                    );
                                    setState(() {});
                                    field.didChange(selectedOptions);
                                  },
                                ),
                            }
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
