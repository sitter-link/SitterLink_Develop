import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/constants.dart';
import 'package:nanny_app/core/enum/work_requirement.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/model/profile_setup_info.dart';
import 'package:nanny_app/core/widgets/forms/app_form_builder.dart';
import 'package:nanny_app/core/widgets/placeholder/notification_placeholder.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/fetch_all_profile_setup_info_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';

class FilterSection extends StatefulWidget {
  final double topPadding;
  final double bottomPadding;
  final NannyFilterParam? initialFilter;
  const FilterSection({
    super.key,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.initialFilter,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  List<CommonFormAttributes> _formItems = [];

  @override
  void initState() {
    super.initState();
    context.read<FetchAllProfileSetupInfoCubit>().fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.topPadding,
        bottom: widget.bottomPadding,
      ),
      child: BlocBuilderWrapper<FetchAllProfileSetupInfoCubit>(
        loadingWidget: Container(
          padding: const EdgeInsets.only(top: 10),
          child: const NotificationPlaceHolderList(length: 5),
        ),
        listener: (context, state) {
          if (state is CommonSuccessState<ProfileSetupInfo>) {
            _formItems = [
              DropDownFormAttribute(
                label: "Looking from,",
                fieldName: "city",
                options: state.data.cities
                    .map((e) => FormOptions(value: e.shortName, label: e.name))
                    .toList(),
                initialValue: widget.initialFilter?.city,
                hintText: "Select",
              ),
              DropDownFormAttribute(
                label: "Age Between,",
                fieldName: "age_between",
                options: Constants.ageOption
                    .map(
                      (e) => FormOptions(
                        value: e.value,
                        label: "${e.value} Years",
                      ),
                    )
                    .toList(),
                initialValue: widget.initialFilter?.minAge != null &&
                        widget.initialFilter?.maxAge != null
                    ? "${widget.initialFilter?.minAge}-${widget.initialFilter?.maxAge}"
                    : null,
                hintText: "Select",
              ),
              DropDownFormAttribute(
                label: "Having Experience Of,",
                fieldName: "experience",
                options: Constants.experienceOption
                    .map(
                      (e) => FormOptions(
                        value: e.value,
                        label: "${e.value} Years",
                      ),
                    )
                    .toList(),
                initialValue: widget.initialFilter?.minExperience != null &&
                        widget.initialFilter?.maxExperience != null
                    ? "${widget.initialFilter?.minExperience}-${widget.initialFilter?.maxExperience}"
                    : null,
                hintText: "Select",
              ),
              DropDownFormAttribute(
                label: "Who can speak",
                fieldName: "language",
                options: state.data.languages
                    .map((e) => FormOptions(value: e.code, label: e.name))
                    .toList(),
                initialValue: widget.initialFilter?.language,
                hintText: "Select",
              ),
              ChipFormAttribute(
                label: "Available for,",
                fieldName: "commitment_type",
                initialValue: widget.initialFilter?.commitmentType,
                options: state.data.commitementType
                    .map(
                      (e) => FormOptions(
                        value: e.id.toString(),
                        label: e.name,
                      ),
                    )
                    .toList(),
              ),
              MultiCheckboxFormAttributes(
                initialValue: widget.initialFilter?.exprienceWith ?? [],
                label: "Experience with,",
                fieldName: "experience_with",
                options: state.data.experiences
                    .map(
                      (e) => FormOptions(
                        value: e.id.toString(),
                        label: e.value,
                      ),
                    )
                    .toList(),
              ),
              MultiCheckboxFormAttributes(
                initialValue:
                    widget.initialFilter?.requirements.keys.toList() ?? [],
                label: "Should have,",
                fieldName: "requirements",
                options: WorkRequirement.values
                    .map(
                      (e) => FormOptions(
                        value: e.boolValueLabel,
                        label: e.label,
                      ),
                    )
                    .toList(),
              ),
              MultiCheckboxFormAttributes(
                initialValue: widget.initialFilter?.skills ?? [],
                label: "Willing to do,",
                fieldName: "skills",
                options: state.data.skills
                    .map(
                      (e) => FormOptions(value: e.id.toString(), label: e.name),
                    )
                    .toList(),
              ),
            ];
            setState(() {});
          }
        },
        builder: (context, state) {
          return Column(
            children: _formItems
                .map(
                  (e) => AppFormBuilder(formAttributes: e),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
