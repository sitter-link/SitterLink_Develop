import 'package:flutter/material.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/widgets/checkbox/checkbox_form_field.dart';
import 'package:nanny_app/core/widgets/checkbox/multi_checkbox_form_field.dart';
import 'package:nanny_app/core/widgets/chip/chip_form_field.dart';
import 'package:nanny_app/core/widgets/date_field/custom_date_time_field.dart';
import 'package:nanny_app/core/widgets/dropdown/custom_dropdown_field.dart';
import 'package:nanny_app/core/widgets/image_pickers/form_image_picker.dart';
import 'package:nanny_app/core/widgets/image_pickers/multi_checkbox_file_picker.dart';
import 'package:nanny_app/core/widgets/radio/radio_form_field.dart';
import 'package:nanny_app/core/widgets/shift_forms/shift_form_fields.dart';
import 'package:nanny_app/core/widgets/text_fields/custom_text_field.dart';

class AppFormBuilder extends StatelessWidget {
  final CommonFormAttributes formAttributes;
  const AppFormBuilder({required this.formAttributes, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (formAttributes) {
      TextFieldFormAttribute() => CustomTextField(
          label: formAttributes.label,
          hintText: (formAttributes as TextFieldFormAttribute).hintText,
          fieldName: (formAttributes as TextFieldFormAttribute).fieldName,
          controller: (formAttributes as TextFieldFormAttribute).controller,
          isRequired: (formAttributes as TextFieldFormAttribute).isRequired,
          onPressed: (formAttributes as TextFieldFormAttribute).onTap,
          validator: (formAttributes as TextFieldFormAttribute).validator ??
              ((formAttributes as TextFieldFormAttribute).isRequired
                  ? (value) => FormValidator.validateFieldNotEmpty(
                      value, (formAttributes as TextFieldFormAttribute).label)
                  : null),
          prefixIcon: (formAttributes as TextFieldFormAttribute).prefix,
          suffixIcon: (formAttributes as TextFieldFormAttribute).suffix,
          maxLines: (formAttributes as TextFieldFormAttribute).maxLines,
          readOnly: (formAttributes as TextFieldFormAttribute).readOnly,
          textInputType:
              (formAttributes as TextFieldFormAttribute).keyboardType,
          inputFormatters:
              (formAttributes as TextFieldFormAttribute).inputFormatters,
          onChanged: (formAttributes as TextFieldFormAttribute).onChanged,
          maxLength: (formAttributes as TextFieldFormAttribute).maxLength,
          bottomPadding:
              (formAttributes as TextFieldFormAttribute).bottomPadding,
          topPadding: (formAttributes as TextFieldFormAttribute).topPadding,
        ),
      DropDownFormAttribute() => CustomDropDownField(
          label: (formAttributes as DropDownFormAttribute).label,
          hintText: (formAttributes as DropDownFormAttribute).hintText,
          options: (formAttributes as DropDownFormAttribute).options,
          isRequired: (formAttributes as DropDownFormAttribute).isRequired,
          fieldName: (formAttributes as DropDownFormAttribute).fieldName,
          initialValue: (formAttributes as DropDownFormAttribute).initialValue,
          onPressed: (formAttributes as DropDownFormAttribute).onPressed,
          onChanged: (formAttributes as DropDownFormAttribute).onChanged,
          readOnly: (formAttributes as DropDownFormAttribute).readOnly,
        ),
      DateTimeFormAttribute() => CustomDateTimeField(
          label: (formAttributes as DateTimeFormAttribute).label,
          hintText: (formAttributes as DateTimeFormAttribute).hintText,
          isRequired: (formAttributes as DateTimeFormAttribute).isRequired,
          fieldName: (formAttributes as DateTimeFormAttribute).fieldName,
          initialValue: (formAttributes as DateTimeFormAttribute).initialValue,
          onChanged: (formAttributes as DateTimeFormAttribute).onChanged,
          dateTimeInputType: (formAttributes as DateTimeFormAttribute).type,
          readOnly: (formAttributes as DateTimeFormAttribute).readOnly,
          maxDate: (formAttributes as DateTimeFormAttribute).maxDate,
          minDate: (formAttributes as DateTimeFormAttribute).minDate,
          currentDate: (formAttributes as DateTimeFormAttribute).currentDate,
        ),
      ImagePickerFormAttributes(
        isRequired: bool isRequired,
        imageUrl: String imageUrl
      ) =>
        FormImagePicker(
          fieldName: formAttributes.fieldName,
          imageUrl: imageUrl,
          label: formAttributes.label,
          initialFile: formAttributes.initialValue,
          onChanged: formAttributes.onChanged,
          isRequired: isRequired,
        ),
      ChipFormAttribute() => ChipFormField(
          key: (formAttributes as ChipFormAttribute).key,
          label: (formAttributes as ChipFormAttribute).label,
          options: (formAttributes as ChipFormAttribute).options,
          fieldName: (formAttributes as ChipFormAttribute).fieldName,
          initialValue: (formAttributes as ChipFormAttribute).initialValue,
          isRequired: (formAttributes as ChipFormAttribute).isRequired,
          onChanged: (formAttributes as ChipFormAttribute).onChanged,
          defaultHosPadding:
              (formAttributes as ChipFormAttribute).defaultHosPadding,
          shortTitleHozPadding:
              (formAttributes as ChipFormAttribute).shortTitleHozPadding,
          controller: (formAttributes as ChipFormAttribute).controller,
          showBorder: (formAttributes as ChipFormAttribute).showBorder,
          readOnly: (formAttributes as ChipFormAttribute).readOnly,
        ),
      CheckboxFormAttributes() => CheckBoxFormField(
          fieldName: formAttributes.fieldName,
          label: formAttributes.label,
          initialValue: formAttributes.initialValue,
          controller: (formAttributes as CheckboxFormAttributes).controller,
          onChanged: (formAttributes as CheckboxFormAttributes).onChanged,
          showBorder: (formAttributes as CheckboxFormAttributes).showBorder,
        ),
      MultiCheckboxFormAttributes() => MultiCheckboxFormField(
          fieldName: formAttributes.fieldName,
          label: formAttributes.label,
          initialValue: formAttributes.initialValue,
          onChanged: (formAttributes as MultiCheckboxFormAttributes).onChanged,
          showBorder:
              (formAttributes as MultiCheckboxFormAttributes).showBorder,
          options: (formAttributes as MultiCheckboxFormAttributes).options,
          isRequired:
              (formAttributes as MultiCheckboxFormAttributes).isRequried,
        ),
      ShiftFormAttributes() => ShiftFormField(
          fieldName: (formAttributes as ShiftFormAttributes).fieldName,
          label: (formAttributes as ShiftFormAttributes).label,
          initialValue: (formAttributes as ShiftFormAttributes).initialValue,
          isRequired: (formAttributes as ShiftFormAttributes).isRequried,
          onChanged: (formAttributes as ShiftFormAttributes).onChanged,
          showBorder: (formAttributes as ShiftFormAttributes).showBorder,
        ),
      RadioFormAttributes() => RadioCheckboxFormField(
          fieldName: (formAttributes as RadioFormAttributes).fieldName,
          label: (formAttributes as RadioFormAttributes).label,
          options: (formAttributes as RadioFormAttributes).options,
          initialValue: (formAttributes as RadioFormAttributes).initialValue,
          isRequired: (formAttributes as RadioFormAttributes).isRequired,
          onChanged: (formAttributes as RadioFormAttributes).onChanged,
          showBorder: (formAttributes as RadioFormAttributes).showBorder,
        ),
      MultiCheckboxFilePickerAttributes() => MultiCheckboxFilePickerFormField(
          fieldName: formAttributes.fieldName,
          label: formAttributes.label,
          initialValue: formAttributes.initialValue,
          onChanged:
              (formAttributes as MultiCheckboxFilePickerAttributes).onChanged,
          options:
              (formAttributes as MultiCheckboxFilePickerAttributes).options,
        ),
      SwitchFormAttributes() => Container(),
    };
  }
}
