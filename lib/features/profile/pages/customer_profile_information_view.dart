import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/profile/cubit/update_avatar_cubit.dart';
import 'package:nanny_app/features/profile/widgets/customer_profile_information_body.dart';

class CustomerProfileInformationView extends StatelessWidget {
  const CustomerProfileInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateAvatarCubit(
        repository: context.read<UserRepository>(),
      ),
      child: const CustomerProfileInformationBody(),
    );
  }
}
