/*
* File Name     : chronicles.dart
* Date Created  : 28th January 2025
* last Modified : 28th January 2025
* Author        : Mrunal Nirajkumar Shah
* Group         : trOlsz Group
* Description   : This file is the start point in this app.
*                It runs the app and send it to the next Screen
*                based on the authentication requirements set by
*                the group.
*
*/

import 'package:chronicles/screens/auth/login_screen.dart';
import 'package:chronicles/screens/auth/pin_login_screen.dart';
import 'package:chronicles/screens/auth/register_screen.dart';
import 'package:chronicles/screens/auth/welcome_screen.dart';
import 'package:chronicles/screens/dashboard/dashboard.dart';
import 'package:chronicles/services/login_auth.dart';
import 'package:chronicles/services/pin_auth.dart';
import 'package:chronicles/themes/galactic_ocean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    Chronicles(),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top,
    ],
  );
}

class Chronicles extends StatelessWidget {
  const Chronicles({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isUserLoginActive = isLoginDone();
    final bool isPinLoginRequired = isPinRequired();

    Widget homeScreen;
    if (isUserLoginActive) {
      homeScreen = isPinLoginRequired ? PinLoginScreen() : Dashboard();
    } else {
      homeScreen = WelcomeScreen();
    }

    return MaterialApp(
      theme: galacticOcean,
      routes: {
        '/WelcomeScreen': (context) => WelcomeScreen(),
        '/Login': (context) => LoginScreen(),
        '/Register': (context) => RegisterScreen(),
        '/Dashboard': (context) => Dashboard(),
      },
      home: homeScreen,
    );
  }
}
