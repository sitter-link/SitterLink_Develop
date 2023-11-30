import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/splash/cubit/startup_cubit.dart';
import 'package:nanny_app/features/splash/widgets/splash_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartUpCubit(
        userRepository: context.read<UserRepository>(),
      )..fetchData(),
      child: const SplashBody(),
    );
  }
}
