import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/model/form_options.dart';
import 'package:nanny_app/core/model/profile_setup_info.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/forms/app_form_builder.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';

class BookStepOneSection extends StatefulWidget {
  final PageController pageController;
  final ProfileSetupInfo profileSetupInfo;
  final GlobalKey<FormBuilderState> formKey;
  const BookStepOneSection({
    super.key,
    required this.pageController,
    required this.profileSetupInfo,
    required this.formKey,
  });

  @override
  State<BookStepOneSection> createState() => _BookStepOneSectionState();
}

class _BookStepOneSectionState extends State<BookStepOneSection>
    with AutomaticKeepAliveClientMixin {
  List<CommonFormAttributes> _formsFields = [];

  @override
  void initState() {
    super.initState();
    _formsFields = [
      RadioFormAttributes(
        initialValue: null,
        label: "Nanny for",
        options: widget.profileSetupInfo.experiences
            .map((e) => FormOptions(value: e.id.toString(), label: e.value))
            .toList(),
        fieldName: "experiences",
        isRequired: true,
      ),
      ChipFormAttribute(
        label: "Job Commitment",
        fieldName: "commitment",
        isRequired: true,
        options: widget.profileSetupInfo.commitementType
            .map(
              (e) => FormOptions(
                value: e.id.toString(),
                label: e.name,
              ),
            )
            .toList(),
      ),
      MultiCheckboxFormAttributes(
        initialValue: [],
        label: "Expect to do,",
        fieldName: "skills",
        isRequried: true,
        options: widget.profileSetupInfo.skills
            .map(
              (e) => FormOptions(
                value: e.id.toString(),
                label: e.name,
              ),
            )
            .toList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return FormBuilder(
      key: widget.formKey,
      child: CustomScrollView(
        slivers: [
          SliverSizedBox(height: 4.hp),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Text(
                "Step 1",
                style: appTextTheme.bodySmallRegular.copyWith(
                  color: CustomTheme.grey,
                ),
              ),
            ),
          ),
          SliverSizedBox(height: 4.hp),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Text(
                "Defining Your Expectations",
                style: appTextTheme.appTitle.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverSizedBox(height: 24.hp),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: _formsFields
                    .map(
                      (e) => AppFormBuilder(
                        formAttributes: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomRoundedButtom(
                  title: "NEXT",
                  horizontalMargin: CustomTheme.horizontalPadding,
                  onPressed: () {
                    if (widget.formKey.currentState!.saveAndValidate()) {
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: context.bottomViewPadding > 0
                      ? context.bottomViewPadding + 10.hp
                      : 20.hp,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
