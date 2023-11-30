import 'package:flutter/material.dart';
import 'package:nanny_app/core/enum/shift_type.dart';
import 'package:nanny_app/core/model/availability.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/profile/enum/week_days.dart';

class NannyAvailableStatusTable extends StatefulWidget {
  final Nanny nanny;
  const NannyAvailableStatusTable({super.key, required this.nanny});

  @override
  State<NannyAvailableStatusTable> createState() =>
      _NannyAvailableStatusTableState();
}

class _NannyAvailableStatusTableState extends State<NannyAvailableStatusTable> {
  List<String> get tableHeaders => [
        '',
        for (ShiftType shiftType in ShiftType.values)
          shiftType.label.capitalize(),
      ];

  Map<String, ({bool morning, bool afternoon, bool evening, bool night})>
      get tableData => {
            for (WeekDays weekDays in WeekDays.values)
              weekDays.shortLabel: (
                morning: widget.nanny.availability
                    .checkWeekdaysAndShift(weekDays, ShiftType.Morning),
                afternoon: widget.nanny.availability
                    .checkWeekdaysAndShift(weekDays, ShiftType.Afternoon),
                evening: widget.nanny.availability
                    .checkWeekdaysAndShift(weekDays, ShiftType.Evening),
                night: widget.nanny.availability
                    .checkWeekdaysAndShift(weekDays, ShiftType.Night),
              ),
          };

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(color: CustomTheme.grey),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: CustomTheme.tableHead,
          ),
          children: tableHeaders.map((e) => _TableHeaderText(text: e)).toList(),
        ),
        ...tableData.entries
            .map(
              (e) => TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 12, top: 16, bottom: 16, right: 25),
                    alignment: Alignment.center,
                    color: CustomTheme.tableHead,
                    child: Text(
                      e.key.toUpperCase(),
                      style: appTextTheme.bodySmallSemiBold.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ),
                  _AvailableStatus(isAvailable: e.value.morning),
                  _AvailableStatus(isAvailable: e.value.afternoon),
                  _AvailableStatus(isAvailable: e.value.evening),
                  _AvailableStatus(isAvailable: e.value.night),
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}

class _TableHeaderText extends StatelessWidget {
  final String text;
  const _TableHeaderText({required this.text});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          text,
          style: appTextTheme.bodySmallSemiBold.copyWith(
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _AvailableStatus extends StatelessWidget {
  final bool isAvailable;
  const _AvailableStatus({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: CustomIconButton(
          icon: isAvailable ? Icons.check : Icons.close,
          backgroundColor:
              isAvailable ? Colors.green.shade100 : Colors.red.shade100,
          iconColor: isAvailable ? Colors.green : Colors.red,
          iconSize: 18,
          padding: 4,
        ),
      ),
    );
  }
}
