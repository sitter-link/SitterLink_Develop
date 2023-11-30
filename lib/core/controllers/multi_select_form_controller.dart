import 'package:flutter/material.dart';
import 'package:nanny_app/core/model/form_options.dart';

class MultiSelectFormController extends ValueNotifier<List<FormOptions>> {
  MultiSelectFormController({List<FormOptions> options = const []})
      : super(options);
}
