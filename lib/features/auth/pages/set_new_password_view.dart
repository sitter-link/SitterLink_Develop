import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/cubit/reset_password_cubit.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/auth/widgets/set_new_password_body.dart';

class SetNewPasswordView extends StatelessWidget {
  final String phone;
  const SetNewPasswordView({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        repository: context.read<UserRepository>(),
      ),
      child: SetNewPasswordBody(phone: phone),
    );
  }
}
