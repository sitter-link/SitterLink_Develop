import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/notification/model/notification.dart';
import 'package:nanny_app/features/notification/repository/notification_repository.dart';

class FetchNotificationCubit extends Cubit<CommonState> {
  final NotificationRepository repository;
  FetchNotificationCubit({required this.repository})
      : super(CommonInitialState());

  fetchNotification() async {
    emit(CommonLoadingState());
    final res = await repository.fetchNotification();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        if (data.isNotEmpty) {
          emit(CommonSuccessState<List<AppNotification>>(data: data));
        } else {
          emit(CommonNoDataState());
        }
      },
    );
  }
}
