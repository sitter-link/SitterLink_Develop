import 'package:flutter/material.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/features/profile/pages/profile_view.dart';
import 'package:nanny_app/features/nanny_history/pages/nanny_history_page.dart';
import 'package:nanny_app/features/nanny_home/pages/nanny_home_view.dart';

class NannyDashboardBody extends StatefulWidget {
  const NannyDashboardBody({super.key});

  @override
  State<NannyDashboardBody> createState() => _NannyDashboardBodyState();
}

class _NannyDashboardBodyState extends State<NannyDashboardBody> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          NannyHomeView(),
          NannyHistoryView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: CustomTheme.primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          color: CustomTheme.grey,
        ),
        selectedItemColor: CustomTheme.primaryColor,
        unselectedItemColor: CustomTheme.grey,
        selectedLabelStyle: appTextTheme.bodySmallMedium,
        selectedFontSize: 14,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          });
        },
        showSelectedLabels: true,
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(NannyIcon.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(NannyIcon.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(NannyIcon.user),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
