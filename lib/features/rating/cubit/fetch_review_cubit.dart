import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/rating/model/review.dart';
import 'package:nanny_app/features/rating/resources/rating_repository.dart';

class FetchReviewListCubit extends Cubit<CommonState> {
  final RatingRepository repository;
  FetchReviewListCubit({required this.repository})
      : super(CommonInitialState());

  fetchReviews() async {
    emit(CommonLoadingState());
    final res = await repository.fetchReviews();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        if (data.isNotEmpty) {
          emit(CommonSuccessState<List<Review>>(data: data));
        } else {
          emit(CommonNoDataState());
        }
      },
    );
  }
}
