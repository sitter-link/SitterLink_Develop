import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/forms/app_form_builder.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/book_nanny_cubit.dart';
import 'package:nanny_app/features/book_nanny/model/book_a_nanny_param.dart';

class BookStepThreeSection extends StatefulWidget {
  final PageController pageController;
  final int nannyId;
  final GlobalKey<FormBuilderState> step1Key;
  final GlobalKey<FormBuilderState> step2Key;
  final GlobalKey<FormBuilderState> step3Key;
  const BookStepThreeSection({
    super.key,
    required this.nannyId,
    required this.pageController,
    required this.step1Key,
    required this.step2Key,
    required this.step3Key,
  });

  @override
  State<BookStepThreeSection> createState() => _BookStepThreeSectionState();
}

class _BookStepThreeSectionState extends State<BookStepThreeSection>
    with AutomaticKeepAliveClientMixin {
  List<CommonFormAttributes> _formsFields = [];

  @override
  void initState() {
    super.initState();
    _formsFields = [
      TextFieldFormAttribute(
        label: "Message",
        fieldName: "additional_message",
        hintText: "Type here...",
        maxLines: 5,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return FormBuilder(
      key: widget.step3Key,
      child: CustomScrollView(
        slivers: [
          SliverSizedBox(height: 4.hp),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Text(
                "Step 3",
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
                "Additional message",
                style: appTextTheme.appTitle.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverSizedBox(height: 12.hp),
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
                  title: "SEND REQUEST",
                  horizontalMargin: CustomTheme.horizontalPadding,
                  onPressed: () {
                    if (widget.step3Key.currentState!.saveAndValidate()) {
                      final Map<String, dynamic> step1Data =
                          widget.step1Key.currentState!.value;
                      final Map<String, dynamic> step2Data =
                          widget.step2Key.currentState!.value;
                      final Map<String, dynamic> step3Data =
                          widget.step3Key.currentState!.value;
                      final param = BookANannyParam.fromFormData(
                        widget.nannyId,
                        step1Data,
                        step2Data,
                        step3Data,
                      );
                      context.read<BookNannyCubit>().bookNanny(param);
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

Map test = {
  "care_needs": [1],
  "commitment": 1,
  "expectations": [1, 2],
  "additional_message": "testing",
  "availability": [
    {
      "date": "2023-11-16",
      "time_slots": [
        {"slug": "morning"},
        {"slug": "afternoon"}
      ]
    },
    {
      "date": "2023-11-18",
      "time_slots": [
        {"slug": "morning"},
        {"slug": "afternoon"}
      ]
    }
  ]
};
