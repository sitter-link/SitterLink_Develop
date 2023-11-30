import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/rating/cubit/fetch_review_cubit.dart';
import 'package:nanny_app/features/rating/resources/rating_repository.dart';
import 'package:nanny_app/features/rating/widgets/rating_and_feedback_body.dart';

class RatingAndFeedBackView extends StatelessWidget {
  const RatingAndFeedBackView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchReviewListCubit(
        repository: context.read<RatingRepository>(),
      )..fetchReviews(),
      child: const RatingAndFeedBackBody(),
    );
  }
}
