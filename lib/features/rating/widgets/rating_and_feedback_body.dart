import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/placeholder/no_data_available.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/features/nanny_details/widgets/review_card.dart';
import 'package:nanny_app/features/rating/cubit/fetch_review_cubit.dart';
import 'package:nanny_app/features/rating/model/review.dart';

class RatingAndFeedBackBody extends StatelessWidget {
  const RatingAndFeedBackBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: const CustomAppBar(
        title: "My Ratings & Feedback",
      ),
      body: BlocBuilderWrapper<FetchReviewListCubit>(
        noDataWidget: const NoDataAvailable(
          message: "No review available",
          image: Assets.review,
        ),
        builder: (context, state) {
          if (state is CommonSuccessState<List<Review>>) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
                vertical: CustomTheme.pageTopPadding,
              ),
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ReviewCard(
                    title: state.data[index].user.fullName,
                    avatar: state.data[index].user.avatar,
                    rating: state.data[index].rating,
                    date: Jiffy.parseFromDateTime(state.data[index].createdAt)
                        .format(pattern: "dd MMM, yyyy")
                        .toUpperCase(),
                    description: state.data[index].message,
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
