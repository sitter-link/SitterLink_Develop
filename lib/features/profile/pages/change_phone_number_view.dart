import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/profile/cubit/check_phone_availability_cubit.dart';
import 'package:nanny_app/features/profile/widgets/change_phone_number_body.dart';

class ChangePhoneNumberView extends StatelessWidget {
  const ChangePhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckPhoneAvailabilityCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: const ChangePhoneNumberBody(),
    );
  }
}
