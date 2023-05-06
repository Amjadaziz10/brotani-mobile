import 'package:brotani/home/home_page.dart';
import 'package:brotani/home/land/add/add_land.dart';
import 'package:brotani/onboarding/onboarding_page.dart';
import 'package:brotani/services/login/login_service.dart';
import 'package:flutter/material.dart';

var appRoutes = {
  '/onboard': (context) => const OnboardingScreen(),
  '/homepage': (context) => const HomePage(),
  '/addland': (context) => const AddLandPage(),
};
