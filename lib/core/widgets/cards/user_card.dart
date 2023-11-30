import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/images/custom_network_image.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/number_utils.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/dot_container.dart';

class UserCard extends StatelessWidget {
  final Widget? bottomSection;
  final VoidCallback? onPressed;
  final VoidCallback? favouriteOnTap;
  final String amountPerHrs;
  final String country;
  final String name;
  final String image;
  final int? age;
  final List<String> chipItems;
  final List<String> pinkChipItems;
  final num? rating;
  final bool isFavorite;
  final String city;
  final num noOfExperience;
  final List<DateTime> bookingDates;
  final String totalAmount;

  final Widget? favoriteSection;
  const UserCard({
    super.key,
    this.bottomSection,
    required this.amountPerHrs,
    required this.name,
    this.country = "",
    this.favouriteOnTap,
    this.onPressed,
    this.favoriteSection,
    required this.image,
    this.age,
    required this.chipItems,
    this.pinkChipItems = const [],
    this.rating,
    this.isFavorite = false,
    required this.city,
    required this.noOfExperience,
    this.bookingDates = const [],
    this.totalAmount = "",
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      margin: EdgeInsets.only(bottom: 16.hp),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomTheme.borderRadius),
            color: Colors.white,
          ),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            CustomTheme.borderRadius,
                          ),
                          child: CustomCachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 90,
                            height: 120,
                            url: image,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  name.capitalize(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: CustomTheme.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                if (rating != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 7.wp,
                                      vertical: 3.wp,
                                    ),
                                    decoration: BoxDecoration(
                                      color: CustomTheme.yellowLight,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Icon(
                                          NannyIcon.starOutline,
                                          color: CustomTheme.yellow,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          rating!.format(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: CustomTheme.yellow,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  NannyIcon.location,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 4.wp,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: city.capitalize(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomTheme.textColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.wp),
                                const DotContainer(
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8.wp),
                                if (amountPerHrs.isNotEmpty)
                                  RichText(
                                    text: TextSpan(
                                      text: "\$$amountPerHrs",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CustomTheme.textColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: "/hrs",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                if (totalAmount.isNotEmpty)
                                  Text(
                                    "\$$totalAmount",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomTheme.textColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            switch (bookingDates.length) {
                              0 => const SizedBox.shrink(),
                              1 => RichText(
                                  text: TextSpan(
                                    text: "Booking Date: ",
                                    style:
                                        appTextTheme.bodySmallRegular.copyWith(
                                      color: CustomTheme.grey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: Jiffy.parseFromDateTime(
                                                bookingDates.first)
                                            .format(pattern: "dd EE, yy")
                                            .toUpperCase(),
                                        style: appTextTheme.bodySmallRegular
                                            .copyWith(
                                          color: CustomTheme.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              >= 2 => Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "From: ",
                                        style: appTextTheme.bodySmallRegular
                                            .copyWith(
                                          color: CustomTheme.grey,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: Jiffy.parseFromDateTime(
                                                    bookingDates.first)
                                                .format(pattern: "dd EE, yy")
                                                .toUpperCase(),
                                            style: appTextTheme.bodySmallRegular
                                                .copyWith(
                                              color: CustomTheme.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: "To: ",
                                            style: appTextTheme.bodySmallRegular
                                                .copyWith(
                                              color: CustomTheme.grey,
                                            ),
                                            children: [
                                          TextSpan(
                                              text: Jiffy.parseFromDateTime(
                                                      bookingDates.last)
                                                  .format(pattern: "dd EE, yy")
                                                  .toUpperCase(),
                                              style: appTextTheme
                                                  .bodySmallRegular
                                                  .copyWith(
                                                color: CustomTheme.grey,
                                              ))
                                        ])),
                                  ],
                                ),
                              _ => const SizedBox.shrink(),
                            },
                            if (bookingDates.isEmpty)
                              Row(
                                children: [
                                  Text(
                                    country.capitalize(),
                                    style:
                                        appTextTheme.bodySmallRegular.copyWith(
                                      color: CustomTheme.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DotContainer(color: CustomTheme.grey),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (age != null)
                                    Text(
                                      "$age yrs",
                                      style: appTextTheme.bodySmallRegular
                                          .copyWith(
                                        color: CustomTheme.grey,
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DotContainer(color: CustomTheme.grey),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${noOfExperience.format()} yrs Exp",
                                    style:
                                        appTextTheme.bodySmallRegular.copyWith(
                                      color: CustomTheme.grey,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                ...chipItems
                                    .map(
                                      (e) => CustomRoundedButtom(
                                        verticalPadding: 10,
                                        color: CustomTheme.lightGreen,
                                        textColor: CustomTheme.greentext,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        title: e,
                                        horizontalPadding: 8,
                                        onPressed: null,
                                        horizontalMargin: 4,
                                      ),
                                    )
                                    .toList(),
                                ...pinkChipItems
                                    .map(
                                      (e) => CustomRoundedButtom(
                                        verticalPadding: 10,
                                        color: const Color(0xFFFFDEFE),
                                        textColor: const Color(0xFFD406CC),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        title: e,
                                        horizontalPadding: 8,
                                        onPressed: null,
                                        horizontalMargin: 4,
                                      ),
                                    )
                                    .toList()
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  if (bottomSection != null)
                    Container(
                      padding: EdgeInsets.only(top: 16.hp),
                      child: bottomSection!,
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: favouriteOnTap,
                child: favoriteSection ??
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        color: Color(0xFFFFDEFE),
                      ),
                      child: Icon(
                        isFavorite ? NannyIcon.heartFill : NannyIcon.heart,
                        size: 24,
                        color: const Color(0xFFD406CC),
                      ),
                    ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
