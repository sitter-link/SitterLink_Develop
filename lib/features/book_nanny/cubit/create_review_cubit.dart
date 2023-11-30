import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_history/model/create_rating_param.dart';

class CreateReviewCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  CreateReviewCubit({required this.repository}) : super(CommonInitialState());

  create(CreateRatingParam param) async {
    emit(CommonLoadingState());
    final res = await repository.createReview(param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<CreateRatingParam>(data: param)),
    );
  }
}
