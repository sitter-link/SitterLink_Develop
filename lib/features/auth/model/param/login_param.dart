import 'package:nanny_app/features/auth/enums/role.dart';

class LoginParam {
  final String phone;
  final String password;
  final Role role;

  const LoginParam({
    required this.phone,
    required this.password,
    required this.role,
  });
}
