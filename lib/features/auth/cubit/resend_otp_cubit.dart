import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/api/firebase_exception_handler.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';

class ResendOtpCubit extends Cubit<CommonState> {
  ResendOtpCubit() : super(CommonInitialState());

  resendOtp(VerifyOtpParam param) async {
    emit(CommonLoadingState());
    try {
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: param.phoneNumber,
        verificationCompleted: (phoneCredential) async {},
        verificationFailed: (e) {
          final erroCode = AuthExceptionHandler.handleException(e);
          final message =
              AuthExceptionHandler.generateExceptionMessage(erroCode);
          emit(CommonErrorState(message: message));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(CommonSuccessState(data: null));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: param.resendToken,
      );
    } on FirebaseAuthException catch (e) {
      final erroCode = AuthExceptionHandler.handleException(e);
      final message = AuthExceptionHandler.generateExceptionMessage(erroCode);
      emit(CommonErrorState(message: message));
    } on PlatformException catch (e) {
      emit(CommonErrorState(message: e.toString()));
    } catch (e) {
      emit(CommonErrorState(message: e.toString()));
    }
  }
}
