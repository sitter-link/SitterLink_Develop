import 'package:flutter/material.dart';
import 'package:nanny_app/core/pages/route_not_found_view.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/pages/create_account_view.dart';
import 'package:nanny_app/features/auth/pages/login_view.dart';
import 'package:nanny_app/features/auth/pages/role_selection_view.dart';
import 'package:nanny_app/features/auth/pages/setup_nanny_profile_view.dart';
import 'package:nanny_app/features/auth/pages/verify_otp_screen.dart';
import 'package:nanny_app/features/book_nanny/pages/book_nanny_view.dart';
import 'package:nanny_app/features/customer_favorite/pages/customer_favorite_view.dart';
import 'package:nanny_app/features/customer_history/pages/payment_view.dart';
import 'package:nanny_app/features/customer_history/pages/ratings_view.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';
import 'package:nanny_app/features/dashboard/presentation/pages/customer_dashboard_view.dart';
import 'package:nanny_app/features/profile/pages/change_phone_number_view.dart';
import 'package:nanny_app/features/profile/pages/customer_profile_information_view.dart';
import 'package:nanny_app/features/dashboard/presentation/pages/nanny_dashboard_view.dart';
import 'package:nanny_app/features/nanny_details/pages/nanny_detail_view.dart';
import 'package:nanny_app/features/looking_for/screens/looking_for_view.dart';
import 'package:nanny_app/features/nanny_notification/pages/nanny_notification_view.dart';
import 'package:nanny_app/features/notification/pages/notifiation_view.dart';
import 'package:nanny_app/features/profile/pages/nanny_profile_information_view.dart';
import 'package:nanny_app/features/rating/pages/rating_and_feedback_view.dart';
import 'package:nanny_app/features/splash/pages/splash_view.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings setting) {
    switch (setting.name) {
      case Routes.splash:
        return PageTransition(
          child: const SplashView(),
          type: PageTransitionType.fade,
        );
      case Routes.login:
        return PageTransition(
          child: LoginView(
            role: setting.arguments as Role,
          ),
          type: PageTransitionType.fade,
        );
      case Routes.customerDashboard:
        return PageTransition(
          child: CustomerDashboardView(
            param: setting.arguments as NannyFilterParam,
          ),
          type: PageTransitionType.fade,
        );
      case Routes.customerFavourite:
        return PageTransition(
          child: const CustomerFavoriteView(),
          type: PageTransitionType.fade,
        );
      case Routes.nannyDashboard:
        return PageTransition(
          child: const NannyDashboardView(),
          type: PageTransitionType.fade,
        );
      case Routes.nannyDetails:
        return PageTransition(
          child: NannyDetailView(
            nannyId: setting.arguments as int,
          ),
          type: PageTransitionType.fade,
        );
      case Routes.roleSelectionView:
        return PageTransition(
          child: const RoleSelectionView(),
          type: PageTransitionType.fade,
        );
      case Routes.nannyProfileInformation:
        return PageTransition(
          child: const NannyProfileInformationView(),
          type: PageTransitionType.fade,
        );
      case Routes.verifyOtp:
        return PageTransition(
          child: VerifyOtpScreen(
            param: setting.arguments as VerifyOtpParam,
          ),
          type: PageTransitionType.fade,
        );
      case Routes.setupNannyProfile:
        return PageTransition(
          child: const SetupNannyProfileView(),
          type: PageTransitionType.fade,
        );
      case Routes.createAccount:
        return PageTransition(
          child: CreateAccountView(role: setting.arguments as Role),
          type: PageTransitionType.fade,
        );
      case Routes.lookingFor:
        return PageTransition(
          child: const LookingForView(),
          type: PageTransitionType.fade,
        );
      case Routes.notification:
        return PageTransition(
          child: const NotificationView(),
          type: PageTransitionType.fade,
        );
      case Routes.bookANanny:
        return PageTransition(
          child: BookNannyView(
            nannyId: setting.arguments as int,
          ),
          type: PageTransitionType.fade,
        );
      case Routes.customerProfileInformation:
        return PageTransition(
          child: const CustomerProfileInformationView(),
          type: PageTransitionType.fade,
        );
      case Routes.nannyNotification:
        return PageTransition(
          child: const NannyNotificationView(),
          type: PageTransitionType.fade,
        );
      case Routes.ratingPage:
        return PageTransition(
          child: RatingsView(bookingId: setting.arguments as int),
          type: PageTransitionType.fade,
        );
      case Routes.ratingandfeedbackPage:
        return PageTransition(
          child: const RatingAndFeedBackView(),
          type: PageTransitionType.fade,
        );
      case Routes.changePhoneNumber:
        return PageTransition(
          child: const ChangePhoneNumberView(),
          type: PageTransitionType.fade,
        );
      case Routes.payment:
        return PageTransition(
          child: PaymentView(
            bookingId: setting.arguments as int,
          ),
          type: PageTransitionType.fade,
        );

      default:
        return PageTransition(
          child: const RouteNotFoundView(),
          type: PageTransitionType.fade,
        );
    }
  }
}
