import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/constants/locale_keys.dart';
import 'package:nanny_app/core/widgets/placeholder/no_data_available.dart';

class RouteNotFoundView extends StatelessWidget {
  const RouteNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NoDataAvailable(
        image: Assets.notFound,
        message: LocaleKeys.routeNotFound.tr(),
      ),
    );
  }
}
