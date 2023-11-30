import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/auth/cubit/resend_otp_cubit.dart';
import 'package:nanny_app/features/auth/widgets/otp_verification_body.dart';

class OtpVerificationView extends StatelessWidget {
  final String phoneNumber;
  final int? resendToken;
  final String verificationId;
  const OtpVerificationView({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    this.resendToken,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResendOtpCubit(),
      child: OtpVerificationBody(
        verificationId: verificationId,
        phoneNumber: phoneNumber,
        resendToken: resendToken,
      ),
    );
  }
}
