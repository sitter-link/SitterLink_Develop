import 'package:nanny_app/features/auth/enums/role.dart';

class VerifyOtpParam {
  final String phoneNumber;
  final String fullName;
  final String password;
  final Role role;
  final String verificationId;
  final int? resendToken;
  final String code;
  final bool isNewAccount;

  VerifyOtpParam({
    required this.phoneNumber,
    required this.fullName,
    required this.role,
    required this.password,
    required this.verificationId,
    this.resendToken,
    this.code = "",
    required this.isNewAccount,
  });

  Map<String, dynamic> toMap() {
    return {
      "phone_number": phoneNumber,
      "fullname": fullName,
      "role": role.shortValue,
      "password": password,
    };
  }

  VerifyOtpParam copyWith({String? code}) {
    return VerifyOtpParam(
      phoneNumber: phoneNumber,
      fullName: fullName,
      role: role,
      password: password,
      verificationId: verificationId,
      resendToken: resendToken,
      code: code ?? this.code,
      isNewAccount: isNewAccount,
    );
  }
}
