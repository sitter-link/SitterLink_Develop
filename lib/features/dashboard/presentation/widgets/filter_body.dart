import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/others/bottom_navigation_bar_with_button.dart';
import 'package:nanny_app/core/widgets/others/filter_section.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';

class FilterBody extends StatefulWidget {
  final ValueChanged<NannyFilterParam> onSearched;
  final NannyFilterParam? initialFilter;
  const FilterBody({
    super.key,
    required this.onSearched,
    this.initialFilter,
  });

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Filter",
        backButtonIcon: CupertinoIcons.clear,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationbarWithButton(
        buttonLabel: "SEARCH",
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            final result = _formKey.currentState!.value;
            final param = NannyFilterParam.fromFormData(result);
            NavigationService.pop();
            widget.onSearched(param);
          }
        },
        prefix: InkWell(
          onTap: () {
            _formKey.currentState!.reset();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Text(
              "CLEAR ALL",
              style: appTextTheme.bodyMedium.copyWith(
                decoration: TextDecoration.underline,
                height: 1.375,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: CustomTheme.horizontalPadding,
            right: CustomTheme.horizontalPadding,
            top: 20.hp,
          ),
          child: FormBuilder(
            key: _formKey,
            child: FilterSection(
              initialFilter: widget.initialFilter,
            ),
          ),
        ),
      ),
    );
  }
}
