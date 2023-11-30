import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_app/core/controllers/multi_select_form_controller.dart';
import 'package:nanny_app/core/enum/shift_type.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/widgets/forms/app_form_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/widgets/image_pickers/multi_checkbox_file_picker_option.dart';

part 'checkbox_form_attributes.dart';
part 'date_time_form_attributes.dart';
part 'dropdown_form_attribute.dart';
part 'radio_form_attributes.dart';
part 'switch_form_attribute.dart';
part 'textfield_form_attributes.dart';
part 'image_picker_form_attributes.dart';
part 'chip_form_attributes.dart';
part 'multi_checkbox_form_attributes.dart';
part 'shift_form_attributes.dart';
part 'multi_checkbox_file_picker_attributes.dart';
sealed class CommonFormAttributes<Type> {
  final ValueChanged<Type>? onChanged;
  final Type? initialValue;
  final String label;
  final String fieldName;

  const CommonFormAttributes({
    this.onChanged,
    required this.initialValue,
    required this.label,
    required this.fieldName,
  });
}
