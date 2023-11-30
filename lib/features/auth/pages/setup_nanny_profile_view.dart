import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/cubit/setup_nanny_profile_cubit.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/auth/widgets/setup_nanny_profile_body.dart';

class SetupNannyProfileView extends StatelessWidget {
  const SetupNannyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupNannyProfileCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: const SetupNannyProfileBody(),
    );
  }
}
