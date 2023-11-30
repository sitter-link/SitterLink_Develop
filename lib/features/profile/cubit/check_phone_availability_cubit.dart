import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/api/firebase_exception_handler.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/utils/dartz_extension.dart';
import 'package:nanny_app/core/utils/google_play_service_utils.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class CheckPhoneAvailabilityCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  CheckPhoneAvailabilityCubit({required this.userRepository})
      : super(CommonInitialState());

  checkAvailability(String phoneNumber, bool isForgetPassword) async {
    emit(CommonLoadingState());
    try {
      final res = await userRepository.checkPhoneAvailability(
        phoneNumber: phoneNumber,
        isForgetPassword: isForgetPassword,
      );
      if (res.isLeft()) {
        emit(CommonErrorState(message: res.asLeft()));
        return;
      }

      if (Platform.isAndroid) {
        final playServiceAvailability =
            await GooglePlayServiceUtils().checkGoogleService;
        if (!playServiceAvailability) {
          emit(CommonErrorState(message: "Play service not available"));
          return;
        }
      }
      final auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        auth.signOut();
      }
      auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneCredential) async {},
        verificationFailed: (e) {
          final erroCode = AuthExceptionHandler.handleException(e);
          final message =
              AuthExceptionHandler.generateExceptionMessage(erroCode);
          emit(CommonErrorState(message: message));
        },
        codeSent: (String verificationId, int? resendToken) {
          final VerifyOtpParam param = VerifyOtpParam(
            phoneNumber: phoneNumber,
            fullName: userRepository.user.value?.fullName ?? '',
            role: userRepository.user.value?.role ?? Role.Parent,
            password: "",
            verificationId: verificationId,
            resendToken: resendToken,
            isNewAccount: false,
          );
          emit(CommonSuccessState<VerifyOtpParam>(data: param));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
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
