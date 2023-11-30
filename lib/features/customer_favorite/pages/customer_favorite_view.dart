import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/fetch_favorite_nannies_list_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/repository/customer_favourite_repository.dart';
import 'package:nanny_app/features/customer_favorite/widgets/customer_favorite_body.dart';

class CustomerFavoriteView extends StatelessWidget {
  const CustomerFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchFavoriteNanniesCubit(
        removeToFavoruteCubit: context.read<RemoveFromFavouriteCubit>(),
        addToFavoruteCubit: context.read<AddToFavouriteCubit>(),
        repository: context.read<FavoriteRepository>(),
      )..fetchFavoriteList(),
      child: const CustomerFavoriteBody(),
    );
  }
}
