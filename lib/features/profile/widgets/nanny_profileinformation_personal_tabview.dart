import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/widgets/list_tile/custom_list_tile.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';

class NannyProfilePersonalInformationTabBarView extends StatelessWidget {
  final Nanny nanny;
  const NannyProfilePersonalInformationTabBarView(
      {super.key, required this.nanny});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.horizontalPadding),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  CustomListTile(
                    title: "Name",
                    suffix: Text(
                      nanny.name,
                      style: appTextTheme.bodySemiBold,
                    ),
                    showBorder: true,
                  ),
                  CustomListTile(
                    title: "Gender",
                    suffix: Text(
                      nanny.gender,
                      style: appTextTheme.bodySemiBold,
                    ),
                  ),
                  CustomListTile(
                    title: "DOB",
                    suffix: Text(
                      nanny.dateOfBirth != null
                          ? Jiffy.parseFromDateTime(nanny.dateOfBirth!)
                              .format(pattern: "dd MMM, yyyy")
                              .toUpperCase()
                          : "N/A",
                      style: appTextTheme.bodySemiBold,
                    ),
                    showBorder: true,
                  ),
                  CustomListTile(
                    title: "Country",
                    suffix: Text(
                      nanny.country,
                      style: appTextTheme.bodySemiBold,
                    ),
                    showBorder: true,
                  ),
                  CustomListTile(
                    title: "City",
                    suffix: Text(
                      nanny.city,
                      style: appTextTheme.bodySemiBold,
                    ),
                    showBorder: true,
                  ),
                  CustomListTile(
                    title: "Address Line-1",
                    suffix: Text(
                      nanny.address,
                      style: appTextTheme.bodySemiBold,
                    ),
                    showBorder: true,
                  ),
                  CustomListTile(
                    title: "Postal Code",
                    suffix: Text(
                      nanny.postalCode,
                      style: appTextTheme.bodySemiBold,
                    ),
                    showBorder: true,
                  ),
                  CustomListTile(
                    title: "Phone",
                    suffix: Text(
                      nanny.phoneNUmber,
                      style: appTextTheme.bodySemiBold,
                    ),
                    showBorder: true,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
