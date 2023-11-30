import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/cubit/register_cubit.dart';
import 'package:nanny_app/features/auth/cubit/resend_otp_cubit.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/auth/widgets/verify_otp_body.dart';
import 'package:nanny_app/features/profile/cubit/change_phone_number_cubit.dart';

class VerifyOtpScreen extends StatelessWidget {
  final VerifyOtpParam param;
  const VerifyOtpScreen({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(
            repository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ChangePhoneNumberCubit(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ResendOtpCubit(),
        ),
      ],
      child: VerifyOtpBody(param: param),
    );
  }
}
