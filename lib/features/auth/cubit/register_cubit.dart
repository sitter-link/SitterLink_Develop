import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/api/firebase_exception_handler.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class RegisterCubit extends Cubit<CommonState> {
  final UserRepository repository;

  RegisterCubit({required this.repository}) : super(CommonInitialState());

  register(VerifyOtpParam param) async {
    emit(CommonLoadingState());
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: param.verificationId,
        smsCode: param.code,
      );
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user != null) {
        final res = await repository.register(param: param);
        res.fold(
          (err) => emit(CommonErrorState(message: err)),
          (data) => emit(CommonSuccessState(data: null)),
        );
      } else {
        emit(CommonErrorState(message: "Unable to verify verification code"));
      }
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
