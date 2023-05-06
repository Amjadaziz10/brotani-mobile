import 'package:brotani/home/home_page.dart';
import 'package:brotani/onboarding/onboarding_page.dart';
import 'package:brotani/routes.dart';
import 'package:brotani/services/login/login_service.dart';
import 'package:flutter/material.dart';
import 'controllers/login/login_switch_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LoginSwitchController.instance.themeSwitch,
      builder: (context, isDark, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: LoginService().getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    strokeWidth: 3.0,
                  ),
                );
              case ConnectionState.none:
                return OnboardingScreen();
              default:
                if (snapshot.data != null) {
                  return HomePage();
                } else {
                  return OnboardingScreen();
                }
            }
          },
        ),
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: appRoutes,
      ),
    );
  }
}
