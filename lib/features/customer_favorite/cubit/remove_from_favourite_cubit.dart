import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/customer_favorite/repository/customer_favourite_repository.dart';

class RemoveFromFavouriteCubit extends Cubit<CommonState> {
  final FavoriteRepository repository;

  RemoveFromFavouriteCubit({required this.repository})
      : super(CommonInitialState());

  unfavourite(int nannyId) async {
    emit(CommonLoadingState());
    final res = await repository.removeFromFavourite(nannyId);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        emit(CommonSuccessState<int>(data: nannyId));
      },
    );
  }
}
