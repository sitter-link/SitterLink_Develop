// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/firebase_utils.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/google_play_service_utils.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/text_fields/custom_text_field.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';

class CreateAccountBody extends StatefulWidget {
  final Role role;
  const CreateAccountBody({super.key, required this.role});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  bool acceptLicense = false;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  setLoadingState(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          showBottomBorder: false,
          showShadow: false,
        ),
        body: FormBuilder(
          key: _formKey,
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
                      "Create an account",
                      style: appTextTheme.pageHeader,
                    ),
                  ),
                  Text(
                    "It’s a simple and quick process.",
                    style: appTextTheme.bodyRegular.copyWith(
                      color: CustomTheme.grey,
                    ),
                  ),
                  CustomTextField(
                    topPadding: 32.hp,
                    label: "Full Name",
                    leftPadding: 0,
                    fieldName: "full_name",
                    rightPadding: 0,
                    isRequired: true,
                    hintText: "Enter Full Name",
                    bottomPadding: 24,
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                        value,
                        "Full Name",
                      );
                    },
                  ),
                  CustomTextField(
                    topPadding: 0,
                    label: "Phone",
                    fieldName: "phone",
                    hintText: "+1123-123-1234",
                    textInputType: TextInputType.phone,
                    leftPadding: 0,
                    rightPadding: 0,
                    bottomPadding: 24,
                    isRequired: true,
                    prefix: Container(
                      padding: EdgeInsets.only(right: 8.wp, left: 12.wp),
                      child: Image.asset(
                        Assets.canada,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        width: 24,
                      ),
                    ),
                    validator: (value) {
                      return FormValidator.validatePhoneNumber(value);
                    },
                  ),
                  CustomTextField(
                    label: "Password",
                    leftPadding: 0,
                    fieldName: "password",
                    rightPadding: 0,
                    isRequired: true,
                    obscureText: true,
                    hintText: "Enter Password",
                    bottomPadding: 32,
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                        value,
                        "Password",
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.hp),
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: acceptLicense,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  acceptLicense = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.wp),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "By creating an account, I agree to ",
                            style: appTextTheme.bodyRegular.copyWith(
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms and conditions",
                                style: appTextTheme.bodySemiBold.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const TextSpan(
                                text: " of the ",
                              ),
                              TextSpan(
                                text: "SitterLink",
                                style: appTextTheme.bodySemiBold,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.hp),
                  CustomRoundedButtom(
                    title: "Create Account".toUpperCase(),
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        if (acceptLicense) {
                          setLoadingState(true);
                          try {
                            if (Platform.isAndroid) {
                              final playServiceAvailability =
                                  await GooglePlayServiceUtils()
                                      .checkGoogleService;
                              if (!playServiceAvailability) {
                                setLoadingState(false);
                                return;
                              }
                            }
                            final auth = FirebaseAuth.instance;
                            if (auth.currentUser != null) {
                              auth.signOut();
                            }
                            auth.verifyPhoneNumber(
                              phoneNumber:
                                  _formKey.currentState!.value["phone"],
                              verificationCompleted: (phoneCredential) async {},
                              verificationFailed: (e) {
                                FirebaseUtils.showMessage(
                                  exception: e,
                                  context: context,
                                );
                                setLoadingState(false);
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                setLoadingState(false);
                                SnackBarUtils.showSuccessMessage(
                                  message:
                                      "Verification code send successfully!!",
                                  context: context,
                                );
                                final VerifyOtpParam param = VerifyOtpParam(
                                  phoneNumber:
                                      _formKey.currentState!.value["phone"],
                                  fullName:
                                      _formKey.currentState!.value["full_name"],
                                  role: widget.role,
                                  password:
                                      _formKey.currentState!.value["password"],
                                  verificationId: verificationId,
                                  resendToken: resendToken,
                                  isNewAccount: true,
                                );

                                NavigationService.pushNamed(
                                  routeName: Routes.verifyOtp,
                                  args: param,
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          } on FirebaseAuthException catch (e) {
                            setLoadingState(false);
                            FirebaseUtils.showMessage(
                              exception: e,
                              context: context,
                            );
                          } on PlatformException catch (e) {
                            SnackBarUtils.showErrorMessage(
                              context: context,
                              message: e.toString(),
                            );
                          } catch (e) {
                            SnackBarUtils.showErrorMessage(
                              context: context,
                              message: e.toString(),
                            );
                          }
                        } else {
                          SnackBarUtils.showErrorMessage(
                            context: context,
                            message: "Please accept license first!!",
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.hp),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: appTextTheme.bodyRegular,
                      children: [
                        TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigationService.pop();
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
      ),
    );
  }
}
