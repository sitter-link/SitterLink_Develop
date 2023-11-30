import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/auth/widgets/forget_password_body.dart';
import 'package:nanny_app/features/profile/cubit/check_phone_availability_cubit.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckPhoneAvailabilityCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: const ForgetPasswordBody(),
    );
  }
}
