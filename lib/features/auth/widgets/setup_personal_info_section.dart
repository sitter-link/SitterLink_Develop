import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/model/profile_setup_info.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/forms/app_form_builder.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/fetch_all_profile_setup_info_cubit.dart';

class SetupPersonalInfoSection extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormBuilderState> personalKeysFields;
  const SetupPersonalInfoSection({
    super.key,
    required this.pageController,
    required this.personalKeysFields,
  });

  @override
  State<SetupPersonalInfoSection> createState() =>
      _SetupPersonalInfoSectionState();
}

class _SetupPersonalInfoSectionState extends State<SetupPersonalInfoSection>
    with AutomaticKeepAliveClientMixin {
  List<CommonFormAttributes> _personalInfoFields = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return SingleChildScrollView(
      child: FormBuilder(
        key: widget.personalKeysFields,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Setup 1",
                style: appTextTheme.bodySmallRegular.copyWith(
                  fontSize: 12,
                  color: CustomTheme.grey,
                ),
              ),
              SizedBox(height: 4.hp),
              Text(
                "Personal Information",
                style: appTextTheme.bodyLargeBold.copyWith(
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 24.hp),
              BlocBuilderWrapper<FetchAllProfileSetupInfoCubit>(
                listener: (context, state) {
                  if (state is CommonSuccessState<ProfileSetupInfo>) {
                    _personalInfoFields = [
                      MultiCheckboxFormAttributes(
                        fieldName: "commitment_type",
                        label: "Commitment Type",
                        isRequried: true,
                        options: state.data.commitementType
                            .map((e) => FormOptions(
                                value: e.id.toString(), label: e.name))
                            .toList(),
                        initialValue: [],
                      ),
                      DropDownFormAttribute(
                        label: "Gender",
                        fieldName: "gender",
                        isRequired: true,
                        options: const [
                          FormOptions(
                            value: "M",
                            label: "Male",
                          ),
                          FormOptions(
                            value: "F",
                            label: "Female",
                          ),
                        ],
                        hintText: "Select Gender",
                      ),
                      DateTimeFormAttribute(
                        label: "Date of Birth",
                        fieldName: "date_of_birth",
                        hintText: "Select Date",
                        currentDate: DateTime(2000),
                        maxDate: DateTime.now()
                            .subtract(const Duration(days: 18 * 365)),
                        isRequired: true,
                      ),
                      DropDownFormAttribute(
                        label: "Country",
                        fieldName: "country",
                        isRequired: true,
                        options: const [
                          FormOptions(
                            value: "CA",
                            label: "Canada",
                          ),
                        ],
                        hintText: "Select Country",
                      ),
                      DropDownFormAttribute(
                        label: "Language",
                        fieldName: "language",
                        isRequired: true,
                        options: state.data.languages
                            .map((e) =>
                                FormOptions(value: e.code, label: e.name))
                            .toList(),
                        hintText: "Select Country",
                      ),
                      DropDownFormAttribute(
                        label: "City",
                        fieldName: "city",
                        isRequired: true,
                        options: state.data.cities
                            .map((e) =>
                                FormOptions(value: e.shortName, label: e.name))
                            .toList(),
                        hintText: "Select City",
                      ),
                      TextFieldFormAttribute(
                        label: "Address Line-1",
                        fieldName: "address",
                        hintText: "Enter Address",
                        isRequired: true,
                      ),
                      TextFieldFormAttribute(
                        label: "Postal Code",
                        fieldName: "postal_code",
                        hintText: "Enter Postal Code",
                        isRequired: true,
                      ),
                      TextFieldFormAttribute(
                        label: "Amount per Hours",
                        hintText: "Enter Amount",
                        fieldName: "amount_per_hour",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        isRequired: true,
                      ),
                    ];
                  }
                },
                builder: (context, state) {
                  if (state is CommonSuccessState<ProfileSetupInfo>) {
                    return Column(
                      children: [
                        ..._personalInfoFields.map(
                          (e) => AppFormBuilder(
                            formAttributes: e,
                          ),
                        ),
                        CustomRoundedButtom(
                          title: "Next",
                          onPressed: () {
                            if (widget.personalKeysFields.currentState!
                                .saveAndValidate()) {
                              widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(height: context.bottomViewPadding + 20.hp),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
