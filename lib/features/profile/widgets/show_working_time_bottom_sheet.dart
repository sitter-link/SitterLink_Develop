import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/enum/shift_type.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/model/day.dart';
import 'package:nanny_app/core/model/timeslot.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/forms/app_form_builder.dart';
import 'package:nanny_app/core/widgets/others/bottomsheet_wrapper.dart';

void showWorkingTimeBottomSheet({
  required BuildContext context,
  required List<Timeslot> timeslots,
  required Day day,
  required ValueChanged<List<String>> onConfirmed,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return _SelectWorkingTimeBottomSheet(
        timeslots: timeslots,
        day: day,
        onConfirmed: onConfirmed,
      );
    },
  );
}

class _SelectWorkingTimeBottomSheet extends StatefulWidget {
  final Day day;
  final List<Timeslot> timeslots;
  final ValueChanged<List<String>> onConfirmed;
  const _SelectWorkingTimeBottomSheet({
    required this.timeslots,
    required this.day,
    required this.onConfirmed,
  });

  @override
  State<_SelectWorkingTimeBottomSheet> createState() =>
      _SelectWorkingTimeBottomSheetState();
}

class _SelectWorkingTimeBottomSheetState
    extends State<_SelectWorkingTimeBottomSheet> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return BottomSheetWrapper(
      child: FormBuilder(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                widget.day.value,
                style: appTextTheme.appTitle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              AppFormBuilder(
                formAttributes: ShiftFormAttributes(
                  initialValue: ShiftsState(
                    afternoon: widget.timeslots.indexWhere(
                            (e) => e.shift == ShiftType.Afternoon) !=
                        -1,
                    evening: widget.timeslots
                            .indexWhere((e) => e.shift == ShiftType.Evening) !=
                        -1,
                    morning: widget.timeslots
                            .indexWhere((e) => e.shift == ShiftType.Morning) !=
                        -1,
                    night: widget.timeslots
                            .indexWhere((e) => e.shift == ShiftType.Night) !=
                        -1,
                  ),
                  label: "",
                  fieldName: "shift",
                ),
              ),
              CustomRoundedButtom(
                title: "SAVE",
                color: CustomTheme.primaryColor,
                onPressed: () {
                  if (formKey.currentState!.saveAndValidate()) {
                    widget.onConfirmed(Map<String, dynamic>.from(
                            formKey.currentState!.value['shift'])
                        .entries
                        .where((e) => e.value == true)
                        .map((e) => e.key)
                        .toList());
                    NavigationService.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
