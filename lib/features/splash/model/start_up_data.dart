import 'package:nanny_app/features/auth/model/user.dart';

class StartUpData {
  final bool isLoggedIn;
  final User? user;

  StartUpData({required this.isLoggedIn, required this.user});
}
