import 'package:firebase_auth/firebase_auth.dart';
import 'package:nanny_app/core/api/firebase_auth_status_enum.dart';

class AuthExceptionHandler {
  static handleException(FirebaseAuthException e) {
    AuthResultStatus status;
    switch (e.code.toUpperCase()) {
      case "ERROR_INVALID_EMAIL":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
        status = AuthResultStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "MISSING-CLIENT-IDENTIFIER":
        status = AuthResultStatus.missingIdentifier;
        break;
      case "INVALID-VERIFICATION-CODE":
        status = AuthResultStatus.invalidVerificationCode;
        break;
      case "INVALID-PHONE-NUMBER":
        status = AuthResultStatus.invalidPhoneNumber;
        break;
      case "SESSION-EXPIRED":
        status = AuthResultStatus.verificationCodeExpire;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(AuthResultStatus exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.missingIdentifier:
        errorMessage = "Unable to identify user.";
        break;
      case AuthResultStatus.invalidVerificationCode:
        errorMessage = "Invalid verification code.";
        break;
      case AuthResultStatus.invalidPhoneNumber:
        errorMessage = "Invalid phone number.";
        break;
      case AuthResultStatus.verificationCodeExpire:
        errorMessage =
            "Verification code expired. Please resend code and try again.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      default:
        errorMessage = "Something went wrong.!!";
    }

    return errorMessage;
  }
}
