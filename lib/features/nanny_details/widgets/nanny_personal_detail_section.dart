// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nanny_app/core/bloc/common_state.dart';

import 'package:nanny_app/core/enum/work_requirement.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/widgets/list_tile/key_value_tile.dart';
import 'package:nanny_app/core/widgets/others/bullet_point.dart';
import 'package:nanny_app/core/widgets/others/section_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/nanny_details/cubits/fetch_nanny_details_cubit.dart';
import 'package:nanny_app/features/nanny_details/widgets/nanny_available_status_table.dart';

class NannyPersonalDetailsSection extends StatelessWidget {
  const NannyPersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return BlocBuilderWrapper<FetchNannyDetailsCubit>(
      builder: (context, state) {
        if (state is CommonSuccessState<Nanny>) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: _PersonalInfo(
                    nanny: state.data,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SectionWrapper(
                  title: "Bio",
                  child: Text(
                    state.data.bio,
                    style: appTextTheme.bodyRegular.copyWith(
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SectionWrapper(
                  title: "Availability",
                  subtitle: "Desire start date immediately.",
                  child: NannyAvailableStatusTable(
                    nanny: state.data,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SectionWrapper(
                  title: "Experience With",
                  child: Column(
                    children: state.data.experiences.map((option) {
                      return BulletPoint(text: option.value);
                    }).toList(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SectionWrapper(
                  title: "Certifications",
                  child: Column(
                    children: WorkRequirement.values
                        .where((e) => switch (e) {
                              WorkRequirement.CPRTraining =>
                                state.data.hasCprTraining,
                              WorkRequirement.CertifiedElderlyCareTraining =>
                                state.data.hasElderlyCareTraining,
                              WorkRequirement.CertifiedNannyTraining =>
                                state.data.hasNannyCerificateTraining,
                              WorkRequirement.FirstAidTraining =>
                                state.data.hasFirstAidPermit,
                              WorkRequirement.WorkPermit =>
                                state.data.hasWorkPermit,
                            })
                        .map((option) {
                      return BulletPoint(text: option.label);
                    }).toList(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SectionWrapper(
                  title: "Have Skills",
                  child: Column(
                    children: state.data.skills.map((option) {
                      return BulletPoint(text: option.name);
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _PersonalInfo extends StatelessWidget {
  final Nanny nanny;
  const _PersonalInfo({required this.nanny});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEADE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          KeyValueTile(
            title: "Country:",
            value: nanny.country.capitalize(),
          ),
          KeyValueTile(
            title: "Language",
            value: nanny.language.capitalize(),
          ),
          KeyValueTile(
            title: "Age:",
            value: "${nanny.age} Years",
          ),
          KeyValueTile(
            title: "Experience:",
            value: "${nanny.noOfExperience} Years",
          ),
          KeyValueTile(
            title: "Open for:",
            value: nanny.commitmentType.map((e) => e.name).join(", "),
          ),
        ],
      ),
    );
  }
}
