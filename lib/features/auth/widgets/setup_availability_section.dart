import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/model/profile_setup_info.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/forms/app_form_builder.dart';
import 'package:nanny_app/core/widgets/others/custom_grid.dart';
import 'package:nanny_app/features/auth/cubit/fetch_all_profile_setup_info_cubit.dart';
import 'package:nanny_app/features/auth/cubit/setup_nanny_profile_cubit.dart';
import 'package:nanny_app/features/auth/model/param/setup_profile_param.dart';

class SetupAvailabilitySection extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormBuilderState> availabilityFieldKeys;
  final GlobalKey<FormBuilderState> personalInfoFieldKeys;
  final GlobalKey<FormBuilderState> experienceFieldKeys;
  const SetupAvailabilitySection({
    super.key,
    required this.pageController,
    required this.availabilityFieldKeys,
    required this.personalInfoFieldKeys,
    required this.experienceFieldKeys,
  });

  @override
  State<SetupAvailabilitySection> createState() =>
      _SetupAvailabilitySectionState();
}

class _SetupAvailabilitySectionState extends State<SetupAvailabilitySection>
    with AutomaticKeepAliveClientMixin {
  List<CommonFormAttributes> _personalInfoFields = [];

  @override
  void initState() {
    super.initState();
    final data = context.read<FetchAllProfileSetupInfoCubit>().state
        as CommonSuccessState<ProfileSetupInfo>;
    _personalInfoFields = [
      ...data.data.days.map(
        (e) => ShiftFormAttributes(
          fieldName: e.id.toString(),
          label: e.value,
          initialValue: ShiftsState(),
        ),
      ),
      TextFieldFormAttribute(
        label: "Bio",
        hintText: "Type Here",
        fieldName: "bio",
        maxLength: 250,
        maxLines: 5,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return SingleChildScrollView(
      child: FormBuilder(
        key: widget.availabilityFieldKeys,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Setup 3",
                style: appTextTheme.bodySmallRegular.copyWith(
                  fontSize: 12,
                  color: CustomTheme.grey,
                ),
              ),
              SizedBox(height: 4.hp),
              Text(
                "Availability & Bio",
                style: appTextTheme.bodyLargeBold.copyWith(
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 16.hp),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFCF2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CustomGridWidget(
                  childrens: [
                    "MOR: 08 am - 12 pm",
                    "AFT: 12 pm - 04 pm",
                    "EVE: 04 pm - 08 pm",
                    "NIG: 08 pm - 12 am"
                  ]
                      .map(
                        (e) => Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 20,
                              color: CustomTheme.yellow,
                            ),
                            SizedBox(width: 4.wp),
                            Text(
                              e,
                              style: appTextTheme.bodySmallSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: 0.75,
                                color: CustomTheme.yellow,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 24.hp),
              ..._personalInfoFields.map(
                (e) => AppFormBuilder(
                  formAttributes: e,
                ),
              ),
              SizedBox(height: 20.hp),
              CustomRoundedButtom(
                title: "Next",
                onPressed: () {
                  if (widget.availabilityFieldKeys.currentState!
                      .saveAndValidate()) {
                    final personalInfoData =
                        widget.personalInfoFieldKeys.currentState!.value;
                    final experienceData =
                        widget.experienceFieldKeys.currentState!.value;
                    final availableData =
                        widget.availabilityFieldKeys.currentState!.value;
                    final param = SetupProfileParam.fromMap(
                      personalInfoData,
                      experienceData,
                      availableData,
                    );
                    context.read<SetupNannyProfileCubit>().updateProfile(param);
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
