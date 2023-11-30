import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/customer_home/repository/nanny_repository.dart';
import 'package:nanny_app/features/profile/cubit/update_availability_cubit.dart';

class FetchNannyDetailsCubit extends Cubit<CommonState> {
  final NannyRepository repository;

  Nanny? nanny;

  AddToFavouriteCubit addToFavoruteCubit;

  StreamSubscription? addToFavoriteStream;

  RemoveFromFavouriteCubit removeToFavoruteCubit;

  StreamSubscription? removeToFavoriteStream;

  UpdateAvailabilityCubit updateAvailabilityCubit;

  StreamSubscription? updateAvailabilityStream;

  FetchNannyDetailsCubit({
    required this.repository,
    required this.removeToFavoruteCubit,
    required this.addToFavoruteCubit,
    required this.updateAvailabilityCubit,
  }) : super(CommonInitialState()) {
    addToFavoriteStream = addToFavoruteCubit.stream.listen((event) {
      if (event is CommonSuccessState<int> && nanny?.id == event.data) {
        if (nanny != null) {
          emit(CommonLoadingState());
          nanny = nanny!.copyWith(isFavorite: true);
          emit(CommonSuccessState<Nanny>(data: nanny!));
        }
      }
    });

    removeToFavoriteStream = removeToFavoruteCubit.stream.listen((event) {
      if (event is CommonSuccessState<int>) {
        if (nanny != null && nanny?.id == event.data) {
          emit(CommonLoadingState());
          nanny = nanny!.copyWith(isFavorite: false);
          emit(CommonSuccessState<Nanny>(data: nanny!));
        }
      }
    });

    updateAvailabilityStream = updateAvailabilityCubit.stream.listen((event) {
      if (event is CommonSuccessState && nanny != null) {
        fetchDetails(nanny!.id);
      }
    });
  }

  fetchDetails(int id) async {
    emit(CommonLoadingState());
    final res = await repository.fetchNanniesDeatils(id);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        nanny = data;
        emit(CommonSuccessState<Nanny>(data: data));
      },
    );
  }

  @override
  Future<void> close() {
    removeToFavoriteStream?.cancel();
    addToFavoriteStream?.cancel();
    updateAvailabilityStream?.cancel();
    return super.close();
  }
}
