import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/model/book_a_nanny_param.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';

class BookNannyCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  BookNannyCubit({required this.repository}) : super(CommonInitialState());

  bookNanny(BookANannyParam param) async {
    emit(CommonLoadingState());
    final res = await repository.bookNanny(param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(data: null)),
    );
  }
}


