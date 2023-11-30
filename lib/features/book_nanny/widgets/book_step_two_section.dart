import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/forms/app_form_builder.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';

class BookStepTwoSection extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormBuilderState> form2Key;
  const BookStepTwoSection({
    super.key,
    required this.pageController,
    required this.form2Key,
  });

  @override
  State<BookStepTwoSection> createState() => _BookStepTwoSectionState();
}

class _BookStepTwoSectionState extends State<BookStepTwoSection>
    with AutomaticKeepAliveClientMixin {
  final Map<int, List<CommonFormAttributes>> _formsFields = {};

  @override
  void initState() {
    super.initState();
    _formsFields[0] = [
      DateTimeFormAttribute(
        label: "Select Date",
        fieldName: "date-0",
        hintText: "yyyy-mm-dd",
        minDate: DateTime.now(),
        isRequired: true,
      ),
      ShiftFormAttributes(
        initialValue: ShiftsState(),
        label: "Select Shifts",
        isRequried: true,
        fieldName: "shifts-0",
      ),
    ];
  }

  _increaseShiftCount() async {
    final int newIndex = _formsFields.entries.last.key + 1;
    _formsFields[newIndex] = [
      DateTimeFormAttribute(
        label: "Select Date",
        fieldName: "date-$newIndex",
        hintText: "yyyy-mm-dd",
        minDate: DateTime.now(),
      ),
      ShiftFormAttributes(
        initialValue: ShiftsState(),
        label: "Select Shifts",
        fieldName: "shifts-$newIndex",
      ),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return FormBuilder(
      key: widget.form2Key,
      child: CustomScrollView(
        slivers: [
          SliverSizedBox(height: 4.hp),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Text(
                "Step 2",
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
                "Select date & time",
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
                children: _formsFields.entries
                    .fold<List<CommonFormAttributes>>(
                        [], (pv, e) => [...pv, ...e.value])
                    .map(
                      (e) => AppFormBuilder(
                        formAttributes: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                CustomRoundedButtom(
                  title: "ADD MORE",
                  horizontalMargin: CustomTheme.horizontalPadding,
                  color: const Color(0xFFEEECFF),
                  textColor: CustomTheme.primaryColor,
                  prefixIcon: Icons.add,
                  horizontalPadding: 20.wp,
                  verticalPadding: 12.hp,
                  onPressed: () {
                    _increaseShiftCount();
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
                SizedBox(height: 20.hp),
                CustomRoundedButtom(
                  title: "NEXT",
                  horizontalMargin: CustomTheme.horizontalPadding,
                  onPressed: () {
                    if (widget.form2Key.currentState!.saveAndValidate()) {
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
