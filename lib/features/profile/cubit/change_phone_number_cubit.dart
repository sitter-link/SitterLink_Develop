import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class ChangePhoneNumberCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  ChangePhoneNumberCubit({required this.userRepository})
      : super(CommonInitialState());

  updatePhoneNumber(VerifyOtpParam param) async {
    emit(CommonLoadingState());
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: param.verificationId,
        smsCode: param.code,
      );
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user != null) {
        final res = await userRepository.changePhoneNumber(
          newPhoneNumber: param.phoneNumber,
        );
        res.fold(
          (err) => emit(CommonErrorState(message: err)),
          (data) => emit(CommonSuccessState(data: null)),
        );
      } else {
        emit(CommonErrorState(message: "Unable to verify verification code"));
      }
    } catch (e) {
      emit(CommonErrorState(message: e.toString()));
    }
  }
}
