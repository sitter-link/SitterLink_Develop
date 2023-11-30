import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/text_fields/custom_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/profile/cubit/check_phone_availability_cubit.dart';

class ChangePhoneNumberBody extends StatefulWidget {
  const ChangePhoneNumberBody({super.key});

  @override
  State<ChangePhoneNumberBody> createState() => _ChangePhoneNumberBodyState();
}

class _ChangePhoneNumberBodyState extends State<ChangePhoneNumberBody> {
  final TextEditingController _oldPhoneController = TextEditingController();
  final TextEditingController _newPhoneController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final userRepo = context.read<UserRepository>();
    _oldPhoneController.text = userRepo.user.value?.phone ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: const CustomAppBar(
        title: "Change Phone Number",
      ),
      body: FormBuilder(
        key: _formKey,
        child: BlocListenerWrapper<CheckPhoneAvailabilityCubit>(
          listener: (context, state) {
            if (state is CommonSuccessState<VerifyOtpParam>) {
              NavigationService.pushNamed(
                routeName: Routes.verifyOtp,
                args: state.data,
              );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomTextField(
                      bottomPadding: 12.hp,
                      topPadding: 32.hp,
                      label: "Old Phone Number",
                      hintText: "+1123-123-1234",
                      controller: _oldPhoneController,
                      textInputType: TextInputType.emailAddress,
                      leftPadding: CustomTheme.horizontalPadding,
                      rightPadding: CustomTheme.horizontalPadding,
                      isRequired: true,
                      readOnly: true,
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
                      topPadding: 12.hp,
                      label: "New Phone Number",
                      hintText: "+1123-123-1234",
                      controller: _newPhoneController,
                      isRequired: true,
                      textInputType: TextInputType.emailAddress,
                      leftPadding: CustomTheme.horizontalPadding,
                      rightPadding: CustomTheme.horizontalPadding,
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
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomRoundedButtom(
                        color: CustomTheme.primaryColor,
                        textColor: Colors.white,
                        horizontalMargin: CustomTheme.horizontalPadding,
                        title: "NEXT",
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            context
                                .read<CheckPhoneAvailabilityCubit>()
                                .checkAvailability(
                                  _newPhoneController.text,
                                  false,
                                );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: context.bottomViewPadding + 20.hp),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
