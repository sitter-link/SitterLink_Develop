import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/list_tile/key_value_tile.dart';
import 'package:nanny_app/core/widgets/others/bottomsheet_wrapper.dart';
import 'package:nanny_app/core/widgets/others/section_wrapper.dart';
import 'package:nanny_app/features/customer_history/model/booking.dart';

void showRequestSummeryBottomSheet({
  required BuildContext context,
  required Booking booking,
  required VoidCallback onAcceptPressed,
  required VoidCallback onRejectPressed,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints.loose(
      Size.fromHeight(
        context.height * 0.8,
      ),
    ),
    builder: (BuildContext context) {
      return _ShowRequestSummaryBottomSheet(
        booking: booking,
        onAcceptPressed: onAcceptPressed,
        onRejectPressed: onRejectPressed,
      );
    },
  );
}

class _ShowRequestSummaryBottomSheet extends StatelessWidget {
  final Booking booking;
  final VoidCallback onAcceptPressed;
  final VoidCallback onRejectPressed;
  const _ShowRequestSummaryBottomSheet({
    required this.booking,
    required this.onAcceptPressed,
    required this.onRejectPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return BottomSheetWrapper(
      child: Flexible(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SectionWrapper(
                title: "Request Summary",
                child: Card(
                  color: CustomTheme.backgroundColor,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        KeyValueTile(
                          title: "Request By:",
                          useSpacer: true,
                          value: booking.user.fullName.capitalize(),
                          valueStyle: appTextTheme.bodySemiBold,
                        ),
                        KeyValueTile(
                          title: "Booked for:",
                          useSpacer: true,
                          value: booking.careNeeded
                              .map((e) => e.value.capitalize())
                              .join(", "),
                          valueStyle: appTextTheme.bodySemiBold,
                        ),
                        KeyValueTile(
                          title: "Job Commitment:",
                          useSpacer: true,
                          value: booking.commitmentType.name.capitalize(),
                          valueStyle: appTextTheme.bodySemiBold,
                        ),
                        KeyValueTile(
                          title: "Expect to do::",
                          useSpacer: true,
                          valueStyle: appTextTheme.bodySemiBold,
                          value: booking.expectations
                              .map((e) => e.name.capitalize())
                              .join(", "),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SectionWrapper(
                title: "Date & Time",
                child: Card(
                  color: CustomTheme.backgroundColor,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: List.generate(
                        booking.bookingDate.length,
                        (index) => KeyValueTile(
                          title: Jiffy.parseFromDateTime(
                                  booking.bookingDate[index].date)
                              .format(pattern: "dd MMM, yyyy")
                              .toUpperCase(),
                          useSpacer: true,
                          value: booking.bookingDate[index].timeslots
                              .map((e) => e.slug.capitalize())
                              .join(", "),
                          valueStyle: appTextTheme.bodySemiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (booking.additionalMessage.trim().isNotEmpty)
                SectionWrapper(
                  title: "Additional Message",
                  child: Card(
                    color: CustomTheme.backgroundColor,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: context.width,
                      child: Text(
                        booking.additionalMessage.trim(),
                        style: appTextTheme.bodyRegular,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 10.hp,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.horizontalPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomRoundedButtom(
                        title: "ACCEPT REQUESTS",
                        prefixIcon: Icons.check_circle_outline,
                        onPressed: () {
                          NavigationService.pop();
                          onAcceptPressed();
                        },
                        iconSize: 18,
                        fontSize: 15,
                        color: CustomTheme.primaryColor,
                        textColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    CustomIconButton(
                      icon: NannyIcon.closeCircle,
                      borderRadius: 8,
                      padding: 13.5,
                      iconSize: 22,
                      onPressed: () {
                        NavigationService.pop();
                        onRejectPressed();
                      },
                      iconColor: CustomTheme.red,
                      backgroundColor: CustomTheme.red.shade100,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
