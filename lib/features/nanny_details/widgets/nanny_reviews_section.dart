import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';

import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/placeholder/no_data_available.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/nanny_details/cubits/fetch_nanny_details_cubit.dart';

import 'package:nanny_app/features/nanny_details/widgets/review_card.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';
import 'package:nanny_app/features/rating/model/review_stat.dart';

class NannyReviewSection extends StatelessWidget {
  const NannyReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return BlocBuilderWrapper<FetchNannyDetailsCubit>(
      builder: (context, state) {
        if (state is CommonSuccessState<Nanny>) {
          return CustomScrollView(
            slivers: [
              if (state.data.reviewStat.individualReview.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.horizontalPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "${state.data.reviewStat.totalCount} Reviews",
                      style: appTextTheme.bodyRegular,
                    ),
                  ),
                ),
              if (state.data.reviewStat.individualReview.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.horizontalPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: RatingSummeryCard(reviewStat: state.data.reviewStat),
                  ),
                ),
              if (state.data.reviewStat.individualReview.isNotEmpty)
                const SliverSizedBox(height: 12),
              if (state.data.reviews.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.horizontalPadding,
                  ),
                  sliver: SliverList.builder(
                    itemCount: state.data.reviews.length,
                    itemBuilder: (context, index) {
                      return ReviewCard(
                        title: state.data.reviews[index].user.fullName,
                        date: Jiffy.parseFromDateTime(
                                state.data.reviews[index].createdAt)
                            .format(pattern: "dd MMM, yyyy"),
                        rating: state.data.reviews[index].rating,
                        avatar: state.data.reviews[index].user.avatar,
                        description: state.data.reviews[index].message,
                      );
                    },
                  ),
                ),
              if (state.data.reviews.isEmpty)
                const SliverToBoxAdapter(
                  child: NoDataAvailable(
                    message: "No Review Available",
                    image: Assets.review,
                  ),
                ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class RatingSummeryCard extends StatelessWidget {
  final ReviewStat reviewStat;
  const RatingSummeryCard({super.key, required this.reviewStat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16, top: 30),
      decoration: BoxDecoration(
        color: CustomTheme.yellow.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: reviewStat.individualReview
            .map(
              (e) => RatingChartRow(
                label: e.rating,
                pct: e.count / reviewStat.totalCount * 100,
              ),
            )
            .toList(),
      ),
    );
  }
}

class RatingChartRow extends StatelessWidget {
  final String label;
  final double pct;
  const RatingChartRow({super.key, required this.label, required this.pct});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    final double containerWidth = SizeUtils.width * 0.6;
    final double filledWidth = containerWidth * (pct / 100);
    return Column(
      children: [
        Row(
          children: [
            Text(label,
                style: appTextTheme.bodyRegular
                    .copyWith(color: CustomTheme.yellow)),
            Text(
              " Star",
              style:
                  appTextTheme.bodyRegular.copyWith(color: CustomTheme.yellow),
            ),
            SizedBox(
              width: 12.wp,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Stack(
                      children: [
                        Container(
                          height: 16,
                          width: containerWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          left: 2,
                          child: Container(
                            width: filledWidth,
                            height: 12,
                            decoration: BoxDecoration(
                              color: CustomTheme.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.wp,
                  ),
                  Text('$pct%'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 14.hp,
        )
      ],
    );
  }
}
