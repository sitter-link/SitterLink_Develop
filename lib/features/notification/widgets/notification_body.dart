import 'package:flutter/material.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/cards/notification_card.dart';
import 'package:nanny_app/core/widgets/placeholder/no_data_available.dart';
import 'package:nanny_app/core/widgets/placeholder/notification_placeholder.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/features/notification/cubit/fetch_notification_cubit.dart';
import 'package:nanny_app/features/notification/model/notification.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: const CustomAppBar(
        showBottomBorder: false,
        title: "Notification",
        showShadow: false,
      ),
      body: BlocBuilderWrapper<FetchNotificationCubit>(
        noDataWidget: const Center(
          child: NoDataAvailable(
            message: "No Notification Available",
            image: Assets.notification,
          ),
        ),
        loadingWidget: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: const NotificationPlaceHolderList(),
          ),
        ),
        builder: (context, state) {
          if (state is CommonSuccessState<List<AppNotification>>) {
            return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationCard(
                  notification: state.data[index],
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
