import 'package:aspen_app/presentation/details_screen/details_screen.dart';
import 'package:flutter/material.dart';

import '../presentation/home_screen/home_screen.dart';
import '../presentation/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String onboardingScreen = '/onboarding_screen';
  static const String homePage = '/home_screen';
  static const String detailsPage = '/details_screen';

  static Map<String, WidgetBuilder> get routes => {
        onboardingScreen: (context) => const OnboardingScreen(),
        homePage: (context) => const HomeScreen(),
        detailsPage: (context) => const DetailsScreen(),
      };
}
