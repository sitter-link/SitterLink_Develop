import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';
import 'package:nanny_app/features/splash/cubit/startup_cubit.dart';
import 'package:nanny_app/features/splash/model/start_up_data.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    SizeUtils.init(context: context);
    return Scaffold(
      body: BlocListener<StartUpCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState<StartUpData>) {
            if ((state.data.isLoggedIn)) {
              if (state.data.user?.role == Role.Parent) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.customerDashboard,
                  (_) => false,
                  arguments: NannyFilterParam(),
                );
              } else {
                if (state.data.user?.hasUserProfile ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.nannyDashboard,
                    (_) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.setupNannyProfile,
                    (_) => false,
                  );
                }
              }
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.roleSelectionView,
                (_) => false,
              );
            }
          }
        },
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Image.asset(
                Assets.splash,
                height: context.height,
                width: context.height,
                fit: BoxFit.cover,
              ),
              Center(
                child: Image.asset(
                  Assets.splashLogo,
                  height: 192.wp,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
