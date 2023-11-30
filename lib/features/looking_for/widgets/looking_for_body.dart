import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_outline_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/others/filter_section.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';

class LookingForBody extends StatefulWidget {
  const LookingForBody({super.key});

  @override
  State<LookingForBody> createState() => _LookingForBodyState();
}

class _LookingForBodyState extends State<LookingForBody> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomOutlineButton(
                title: "Skip",
                horizontalPadding: 16,
                verticalPadding: 9,
                textColor: CustomTheme.textColor,
                borderColor: CustomTheme.grey,
                onPressed: () {
                  NavigationService.pushNamedAndRemoveUntil(
                    routeName: Routes.customerDashboard,
                    args: NannyFilterParam(),
                  );
                },
                borderRadius: 100,
                fontSize: 12,
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24.hp, bottom: 8.hp),
                  child: Text(
                    "Let’s find one",
                    style: appTextTheme.pageHeader,
                  ),
                ),
                Text(
                  "Find one who fits to your requirements",
                  style: appTextTheme.bodyRegular.copyWith(
                    color: CustomTheme.grey,
                  ),
                ),
                FilterSection(
                  topPadding: 28.hp,
                  bottomPadding: 6.hp,
                ),
                CustomRoundedButtom(
                  title: "SEARCH",
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      final result = _formKey.currentState!.value;
                      final param = NannyFilterParam.fromFormData(result);
                      NavigationService.pushNamedAndRemoveUntil(
                        routeName: Routes.customerDashboard,
                        args: param,
                      );
                    }
                  },
                ),
                SizedBox(height: 16.hp),
                CustomOutlineButton(
                  title: "SKIP FOR NOW",
                  onPressed: () {
                    NavigationService.pushNamedAndRemoveUntil(
                      routeName: Routes.customerDashboard,
                      args: NannyFilterParam(),
                    );
                  },
                ),
                SizedBox(height: context.bottomViewPadding + 20.hp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
