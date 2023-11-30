import 'package:flutter/material.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/widgets/create_account_body.dart';

class CreateAccountView extends StatelessWidget {
  final Role role;
  const CreateAccountView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return CreateAccountBody(role: role);
  }
}
