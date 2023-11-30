import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/api/firebase_exception_handler.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';

class FirebaseUtils {
  static void showMessage({
    required FirebaseAuthException exception,
    required BuildContext context,
  }) {
    final erroCode = AuthExceptionHandler.handleException(exception);
    final message = AuthExceptionHandler.generateExceptionMessage(erroCode);
    SnackBarUtils.showErrorMessage(
      context: context,
      message: message,
    );
  }
}
