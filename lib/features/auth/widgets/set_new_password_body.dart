import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/text_fields/custom_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/reset_password_cubit.dart';

class SetNewPasswordBody extends StatefulWidget {
  final String phone;
  const SetNewPasswordBody({super.key, required this.phone});

  @override
  State<SetNewPasswordBody> createState() => _SetNewPasswordBodyState();
}

class _SetNewPasswordBodyState extends State<SetNewPasswordBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Set New Password",
      ),
      body: BlocListenerWrapper<ResetPasswordCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: "Password Updated Successfully!!",
            );
            NavigationService.popUntilFirstPage();
          }
        },
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Column(
                children: [
                  CustomTextField(
                    label: "New Password",
                    hintText: "Enter New Password",
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      return FormValidator.validatePassword(
                        value,
                        label: "Password",
                      );
                    },
                  ),
                  CustomTextField(
                    label: "Confirm Password",
                    hintText: "Enter Confirm Password",
                    controller: confirmPasswordController,
                    bottomPadding: 30,
                    obscureText: true,
                    validator: (value) {
                      return FormValidator.validateConfirmPassword(
                        value,
                        passwordController.text,
                        label: "Confirm Password",
                      );
                    },
                  ),
                  CustomRoundedButtom(
                    title: "Set Password",
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        context.read<ResetPasswordCubit>().resetPassword(
                              phone: widget.phone,
                              password: passwordController.text,
                            );
                      }
                    },
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
