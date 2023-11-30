import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:nanny_app/core/widgets/image_pickers/multi_checkbox_file_picker_option.dart';
import 'package:nanny_app/features/auth/cubit/fetch_all_profile_setup_info_cubit.dart';

class SetupExperienceSection extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormBuilderState> experienceFieldsKeys;
  const SetupExperienceSection({
    super.key,
    required this.pageController,
    required this.experienceFieldsKeys,
  });

  @override
  State<SetupExperienceSection> createState() => _SetupExperienceSectionState();
}

class _SetupExperienceSectionState extends State<SetupExperienceSection>
    with AutomaticKeepAliveClientMixin {
  final List<MultiCheckboxFilePickerOption> cerfications = const [
    MultiCheckboxFilePickerOption(
      value: "work_permit_pr",
      label: "Work Permit / PR Holder",
      booleanValueKey: "has_work_permit",
      isRequired: true,
    ),
    MultiCheckboxFilePickerOption(
      value: "first_aid_training_certificate",
      label: "First Aid Training",
      booleanValueKey: "has_first_aid_training",
    ),
    MultiCheckboxFilePickerOption(
      value: "cpr_training_certificate",
      label: "CPR Training",
      booleanValueKey: "has_cpr_training",
    ),
    MultiCheckboxFilePickerOption(
      value: "nanny_training_certificate",
      label: "Certified Nanny Training",
      booleanValueKey: "has_nanny_training",
    ),
    MultiCheckboxFilePickerOption(
      value: "elderly_care_training_certificate",
      label: "Certified Elderly Care Training",
      booleanValueKey: "has_elderly_care_training",
    ),
  ];
  List<CommonFormAttributes> _experienceInfoFields = [];

  @override
  void initState() {
    super.initState();
    final data = context.read<FetchAllProfileSetupInfoCubit>().state
        as CommonSuccessState<ProfileSetupInfo>;
    _experienceInfoFields = [
      TextFieldFormAttribute(
        label: "No of Experience",
        hintText: "Enter No of Experience",
        isRequired: true,
        keyboardType: TextInputType.number,
        fieldName: "no_of_experience",
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      MultiCheckboxFormAttributes(
        fieldName: "experinence",
        label: "You are experience with,",
        options: data.data.experiences
            .map(
              (e) => FormOptions(
                value: e.id.toString(),
                label: e.value,
              ),
            )
            .toList(),
        initialValue: [],
      ),
      MultiCheckboxFilePickerAttributes(
        initialValue: [],
        label: "Your certifications",
        fieldName: "certification",
        options: cerfications,
      ),
      MultiCheckboxFormAttributes(
        initialValue: [],
        label: "Additional Skills/Willing to do,",
        fieldName: "skill",
        isRequried: true,
        options: data.data.skills
            .map((e) => FormOptions(value: e.id.toString(), label: e.name))
            .toList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return SingleChildScrollView(
      child: FormBuilder(
        key: widget.experienceFieldsKeys,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Setup 2",
                style: appTextTheme.bodySmallRegular.copyWith(
                  fontSize: 12,
                  color: CustomTheme.grey,
                ),
              ),
              SizedBox(height: 4.hp),
              Text(
                "Experience & Certifications",
                style: appTextTheme.bodyLargeBold.copyWith(
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 24.hp),
              ..._experienceInfoFields.map(
                (e) => AppFormBuilder(
                  formAttributes: e,
                ),
              ),
              CustomRoundedButtom(
                title: "Next",
                onPressed: () {
                  if (widget.experienceFieldsKeys.currentState!
                      .saveAndValidate()) {
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
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
