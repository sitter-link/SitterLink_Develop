import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';
import 'package:nanny_app/features/customer_home/repository/nanny_repository.dart';

class SearchNanniesCubit extends Cubit<CommonState> {
  final NannyRepository repository;

  final List<Nanny> nannyList = [];

  AddToFavouriteCubit addToFavoruteCubit;

  StreamSubscription? addToFavoriteStream;

  RemoveFromFavouriteCubit removeToFavoruteCubit;

  StreamSubscription? removeToFavoriteStream;

  SearchNanniesCubit({
    required this.repository,
    required this.addToFavoruteCubit,
    required this.removeToFavoruteCubit,
  }) : super(CommonInitialState()) {
    addToFavoriteStream = addToFavoruteCubit.stream.listen((event) {
      if (event is CommonSuccessState<int>) {
        emit(CommonLoadingState());
        final index = nannyList.indexWhere((e) => e.id == event.data);
        if (index != -1) {
          nannyList[index] = nannyList[index].copyWith(isFavorite: true);
        }
        emit(CommonSuccessState<List<Nanny>>(data: nannyList));
      }
    });

    removeToFavoriteStream = removeToFavoruteCubit.stream.listen((event) {
      if (event is CommonSuccessState<int>) {
        emit(CommonLoadingState());
        final index = nannyList.indexWhere((e) => e.id == event.data);
        if (index != -1) {
          nannyList[index] = nannyList[index].copyWith(isFavorite: false);
        }
        emit(CommonSuccessState<List<Nanny>>(data: nannyList));
      }
    });
  }

  search(NannyFilterParam param) async {
    emit(CommonLoadingState());
    final res = await repository.searchNannies(param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        nannyList.clear();
        nannyList.addAll(data);
        if (data.isNotEmpty) {
          emit(CommonSuccessState<List<Nanny>>(data: data));
        } else {
          emit(CommonNoDataState());
        }
      },
    );
  }

  @override
  Future<void> close() {
    addToFavoriteStream?.cancel();
    removeToFavoriteStream?.cancel();
    return super.close();
  }
}
