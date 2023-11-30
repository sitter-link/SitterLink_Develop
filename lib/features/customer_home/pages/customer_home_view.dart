import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_home/cubit/search_nannies_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';
import 'package:nanny_app/features/customer_home/repository/nanny_repository.dart';
import 'package:nanny_app/features/customer_home/widgets/customer_home_body.dart';

class CustomerHomeView extends StatelessWidget {
  final NannyFilterParam param;
  const CustomerHomeView({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchNanniesCubit(
        repository: context.read<NannyRepository>(),
        addToFavoruteCubit: context.read<AddToFavouriteCubit>(),
        removeToFavoruteCubit: context.read<RemoveFromFavouriteCubit>(),
      )..search(param),
      child: CustomerHomeBody(param: param),
    );
  }
}
