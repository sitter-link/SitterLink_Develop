import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/cubit/login_cubit.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/auth/widgets/login_body.dart';

class LoginView extends StatelessWidget {
  final Role role;
  const LoginView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        repository: context.read<UserRepository>(),
      ),
      child: LoginBody(role: role),
    );
  }
}
