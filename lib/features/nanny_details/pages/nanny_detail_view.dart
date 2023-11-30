import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/repository/nanny_repository.dart';
import 'package:nanny_app/features/nanny_details/cubits/fetch_nanny_details_cubit.dart';
import 'package:nanny_app/features/nanny_details/widgets/nanny_detail_body.dart';
import 'package:nanny_app/features/profile/cubit/update_availability_cubit.dart';

class NannyDetailView extends StatelessWidget {
  final int nannyId;
  const NannyDetailView({super.key, required this.nannyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNannyDetailsCubit(
        repository: context.read<NannyRepository>(),
        addToFavoruteCubit: context.read<AddToFavouriteCubit>(),
        removeToFavoruteCubit: context.read<RemoveFromFavouriteCubit>(),
        updateAvailabilityCubit: context.read<UpdateAvailabilityCubit>(),
      )..fetchDetails(nannyId),
      child: NannyDetailBody(nannyId: nannyId),
    );
  }
}
