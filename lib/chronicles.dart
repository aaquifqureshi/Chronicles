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

import 'package:chronicles/screens/auth/change_password.dart';
import 'package:chronicles/screens/auth/forgot_password_screen.dart';
import 'package:chronicles/screens/auth/login_screen.dart';
import 'package:chronicles/screens/auth/pin_login_screen.dart';
import 'package:chronicles/screens/auth/register_screen.dart';
import 'package:chronicles/screens/auth/welcome_screen.dart';
import 'package:chronicles/screens/dashboard/dashboard.dart';
import 'package:chronicles/screens/profile/profile_screen.dart';
import 'package:chronicles/services/login_auth.dart';
import 'package:chronicles/services/pin_auth.dart';
import 'package:chronicles/themes/galactic_ocean.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  FirebaseFirestore.instance.clearPersistence();

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
    return FutureBuilder(
      future: _getHomeScreen(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        Widget? homeScreen = snapshot.data;
        return MaterialApp(
          theme: galacticOcean,
          routes: {
            '/WelcomeScreen': (context) => WelcomeScreen(),
            '/Login': (context) => LoginScreen(),
            '/Register': (context) => RegisterScreen(),
            '/Dashboard': (context) => Dashboard(),
            '/ForgotPassword': (context) => ForgotPasswordScreen(),
            '/ChangePassword': (context) => ChangePasswordScreen(),
            '/ProfileScreen': (context) => ProfileScreen(),
          },
          home: homeScreen,
        );
      },
    );
  }
}

Future<Widget> _getHomeScreen(BuildContext context) async {
  final bool isUserLoginActive = await isLoginDone();
  final bool isPinLoginRequired = await isPinRequired();
  print(isUserLoginActive);
  print(isPinLoginRequired);
  if (isUserLoginActive) {
    return isPinLoginRequired ? PinLoginScreen() : Dashboard();
  } else {
    return WelcomeScreen();
  }
}
