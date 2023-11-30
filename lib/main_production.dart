import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/constants/locale_keys.dart';
import 'package:nanny_app/core/database/database_service.dart';
import 'package:nanny_app/core/injector/injection.dart';
import 'package:nanny_app/core/routes/route_generator.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/wrapper/localization_wrapper.dart';
import 'package:nanny_app/core/wrapper/multi_bloc_wrapper.dart';
import 'package:nanny_app/core/wrapper/multi_repository_wrapper.dart';
import 'package:nanny_app/core/wrapper/notification_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await DatabaseService.init();
  await DI.init(env: Env.production());
  runApp(
    const LocalizationWrapper(
      child: MyAppProduction(),
    ),
  );
}

class MyAppProduction extends StatefulWidget {
  const MyAppProduction({super.key});

  @override
  State<MyAppProduction> createState() => _MyAppProductionState();
}

class _MyAppProductionState extends State<MyAppProduction> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryWrapper(
      child: MultiBlocWrapper(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(NavigationService.context).unfocus();
          },
          child: NotificationWrapper(
            child: MaterialApp(
              title: LocaleKeys.appName.tr(),
              theme: ThemeData(
                primarySwatch: CustomTheme.primaryColor,
                textTheme: GoogleFonts.urbanistTextTheme(),
                extensions: [
                  AppTextTheme.light(),
                ],
              ),
              navigatorKey: NavigationService.navigationKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              onGenerateRoute: RouteGenerator.routeGenerator,
              initialRoute: Routes.splash,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    DatabaseService.dispose();
    super.dispose();
  }
}
