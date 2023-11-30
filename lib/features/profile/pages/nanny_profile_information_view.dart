import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/repository/nanny_repository.dart';
import 'package:nanny_app/features/nanny_details/cubits/fetch_nanny_details_cubit.dart';
import 'package:nanny_app/features/profile/cubit/update_availability_cubit.dart';
import 'package:nanny_app/features/profile/cubit/update_avatar_cubit.dart';
import 'package:nanny_app/features/profile/widgets/nanny_profile_information_body.dart';

class NannyProfileInformationView extends StatelessWidget {
  const NannyProfileInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateAvatarCubit(
            repository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchNannyDetailsCubit(
            repository: context.read<NannyRepository>(),
            addToFavoruteCubit: context.read<AddToFavouriteCubit>(),
            removeToFavoruteCubit: context.read<RemoveFromFavouriteCubit>(),
            updateAvailabilityCubit: context.read<UpdateAvailabilityCubit>(),
          )..fetchDetails(context.read<UserRepository>().user.value!.id),
        ),
      ],
      child: const NannyProfileInformationBody(),
    );
  }
}
