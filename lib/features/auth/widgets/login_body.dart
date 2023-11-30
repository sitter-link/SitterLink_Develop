import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/constants/locale_keys.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/text_fields/custom_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/login_cubit.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/model/param/login_param.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/auth/pages/forget_password_view.dart';

class LoginBody extends StatefulWidget {
  final Role role;
  const LoginBody({super.key, required this.role});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        showShadow: false,
      ),
      backgroundColor: Colors.white,
      body: BlocListenerWrapper<LoginCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState<User>) {
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: LocaleKeys.loggedInSuccessfully.tr(),
            );
            if (state.data.role == Role.Nanny) {
              if (state.data.hasUserProfile) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.nannyDashboard,
                  (route) => false,
                );
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.setupNannyProfile,
                  (route) => false,
                );
              }
            }
            if (state.data.role == Role.Parent) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.lookingFor,
                (route) => false,
              );
            }
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 24.hp, bottom: 8.hp),
                    child: Text(
                      "Welcome Back!",
                      style: appTextTheme.pageHeader,
                    ),
                  ),
                  Text(
                    "Login to your account.",
                    style: appTextTheme.bodyRegular.copyWith(
                      color: CustomTheme.grey,
                    ),
                  ),
                  CustomTextField(
                    topPadding: 32.hp,
                    label: "Phone",
                    hintText: "+1123-123-1234",
                    controller: _phoneController,
                    textInputType: TextInputType.phone,
                    leftPadding: 0,
                    rightPadding: 0,
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
                      return FormValidator.validateFieldNotEmpty(
                        value,
                        "Phone",
                      );
                    },
                  ),
                  CustomTextField(
                    label: "Password",
                    hintText: "Enter Password",
                    controller: _passwordController,
                    obscureText: true,
                    leftPadding: 0,
                    rightPadding: 0,
                    validator: (value) {
                      return FormValidator.validatePassword(value);
                    },
                    bottomPadding: 32.hp,
                  ),
                  CustomRoundedButtom(
                    title: "LOG IN",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                              LoginParam(
                                phone: _phoneController.text,
                                password: _passwordController.text,
                                role: widget.role,
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(height: 24.hp),
                  RichText(
                    text: TextSpan(
                      text: "Don’t have an account? ",
                      style: appTextTheme.bodyRegular,
                      children: [
                        TextSpan(
                          text: "Create an account",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigationService.pushNamed(
                                routeName: Routes.createAccount,
                                args: widget.role,
                              );
                            },
                          style: appTextTheme.bodySemiBold.copyWith(
                            color: CustomTheme.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 24.hp),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: "Forget Password?",
                        style: appTextTheme.bodyRegular.copyWith(
                          decoration: TextDecoration.underline,
                          letterSpacing: 0.4,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService.push(
                              target: const ForgetPasswordView(),
                            );
                          },
                      ),
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
