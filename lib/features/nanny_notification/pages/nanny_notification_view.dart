import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/nanny_notification/widgets/nanny_notification_body.dart';
import 'package:nanny_app/features/notification/cubit/fetch_notification_cubit.dart';
import 'package:nanny_app/features/notification/repository/notification_repository.dart';

class NannyNotificationView extends StatelessWidget {
  const NannyNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNotificationCubit(
        repository: context.read<NotificationRepository>(),
      )..fetchNotification(),
      child: const NannyNotificationBody(),
    );
  }
}
