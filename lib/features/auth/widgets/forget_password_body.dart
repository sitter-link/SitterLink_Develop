// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/text_fields/custom_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/pages/otp_verification_view.dart';
import 'package:nanny_app/features/profile/cubit/check_phone_availability_cubit.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  setLoadingState(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Forgot Password",
        ),
        backgroundColor: Colors.white,
        body: BlocListenerWrapper<CheckPhoneAvailabilityCubit>(
          listener: (context, state) {
            if (state is CommonSuccessState<VerifyOtpParam>) {
              NavigationService.push(
                target: OtpVerificationView(
                  verificationId: state.data.verificationId,
                  phoneNumber: state.data.phoneNumber,
                  resendToken: state.data.resendToken,
                ),
              );
            }
          },
          child: FormBuilder(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
                SliverToBoxAdapter(
                  child: CustomTextField(
                    label: "Phone Number",
                    hintText: "+1123-123-1234",
                    controller: controller,
                    leftPadding: CustomTheme.horizontalPadding,
                    rightPadding: CustomTheme.horizontalPadding,
                    textInputType: TextInputType.phone,
                    bottomPadding: 24,
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
                ),
                SliverToBoxAdapter(
                  child: CustomRoundedButtom(
                    title: "Continue",
                    horizontalMargin: CustomTheme.horizontalPadding,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<CheckPhoneAvailabilityCubit>()
                            .checkAvailability(controller.text, true);
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32.hp)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
