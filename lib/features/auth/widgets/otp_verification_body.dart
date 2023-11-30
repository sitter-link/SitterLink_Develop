import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/resend_otp_cubit.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/pages/set_new_password_view.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationBody extends StatefulWidget {
  final String phoneNumber;
  final int? resendToken;
  final String verificationId;
  const OtpVerificationBody({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    this.resendToken,
  });

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

class _OtpVerificationBodyState extends State<OtpVerificationBody> {
  final TextEditingController _pinController = TextEditingController();

  verifyPressed() async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _pinController.text,
      );
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user != null) {
        NavigationService.push(
          target: SetNewPasswordView(
            phone: widget.phoneNumber,
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        SnackBarUtils.showErrorMessage(
          context: context,
          message: "Unable to verify verification code",
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      SnackBarUtils.showErrorMessage(
        context: context,
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        showShadow: false,
        showBottomBorder: false,
      ),
      body: BlocListenerWrapper<ResendOtpCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: "Verification Code Send Successfully",
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24.hp, bottom: 8.hp),
                  child: Text(
                    "Verify OTP",
                    style: appTextTheme.pageHeader,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Add 6 digit code sent to your phone number,\n",
                    style: appTextTheme.bodyRegular.copyWith(
                      height: 1.5,
                      color: CustomTheme.grey,
                    ),
                    children: [
                      TextSpan(
                        text: widget.phoneNumber,
                        style: appTextTheme.bodyBold.copyWith(
                          color: CustomTheme.primaryColor,
                          height: 1.6,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 44.hp),
                Pinput(
                  controller: _pinController,
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: 48.wp,
                    width: 48.wp,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomTheme.grey.shade300,
                        width: 1,
                      ),
                      borderRadius:
                          BorderRadius.circular(CustomTheme.borderRadius),
                    ),
                    textStyle: appTextTheme.bodyMedium.copyWith(
                      color: CustomTheme.textColor,
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    height: 48.wp,
                    width: 48.wp,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: CustomTheme.primaryColor.shade400, width: 1),
                      borderRadius:
                          BorderRadius.circular(CustomTheme.borderRadius),
                    ),
                    textStyle: appTextTheme.bodyMedium.copyWith(
                      color: CustomTheme.grey.shade900,
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    height: 48.wp,
                    width: 48.wp,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: CustomTheme.primaryColor.shade400, width: 1),
                      borderRadius:
                          BorderRadius.circular(CustomTheme.borderRadius),
                    ),
                    textStyle: appTextTheme.bodyMedium.copyWith(
                      color: CustomTheme.grey.shade900,
                    ),
                  ),
                  onCompleted: (value) {
                    verifyPressed();
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                SizedBox(height: 32.hp),
                CustomRoundedButtom(
                  title: "Verify".toUpperCase(),
                  onPressed: () async {
                    verifyPressed();
                  },
                ),
                SizedBox(height: 20.hp),
                RichText(
                  text: TextSpan(
                    text: "Didn’t received code? ",
                    style: appTextTheme.bodyRegular,
                    children: [
                      TextSpan(
                        text: "Resend",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<ResendOtpCubit>().resendOtp(
                                  VerifyOtpParam(
                                    phoneNumber: widget.phoneNumber,
                                    fullName: "",
                                    role: Role.Nanny,
                                    password: "",
                                    verificationId: widget.verificationId,
                                    resendToken: widget.resendToken,
                                    isNewAccount: false,
                                  ),
                                );
                          },
                        style: appTextTheme.bodyBold.copyWith(
                          color: CustomTheme.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
