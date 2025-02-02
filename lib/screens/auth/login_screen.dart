/*
* File Name     : chronicles.dart
* Date Created  : 1st February 2025
* last Modified : 1st February 2025
* Author        : Aaquif Qureshi
* Group         : trOlsz Group
* Description   : This file is the start point in this app.
*                It runs the app and send it to the next Screen
*                based on the authentication requirements set by
*                the group.
*
*/

import 'package:chronicles/screens/auth/register_screen.dart';
import 'package:chronicles/screens/auth/welcome_screen.dart';
import 'package:chronicles/screens/dashboard/dashboard.dart';
import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:chronicles/utilities/components/textfields/gray_textfield.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final double logoWidth = 130.0;
  final double logoHeight = 130.0;
  final double logoTop = 15.0;
  final double accLogin_emailText = 40.0;
  final double topPadding = 0;
  final double bottomPadding = 18;

  final String accountLoginText = 'Account Login';
  final String emailHint = 'Enter your email';
  final String emailText = 'Email';
  final String passwordText = 'Password';
  final String passwordHint = 'Enter your password';
  final String forgotPasswordText = 'Forgot password?';
  final String loginText = 'Login';
  final double verticalButtonMargin = 30.0;
  final double buttonHeight = 50.0;
  final double horizontalMargin = 0.0;
  final Color loginTextColor = Color(0xFFFFFFFF);
  final Color loginRegisterHighlightColor = Color(0xFF35879F);
  final Color loginRegisterSplashColor = Color(0xFF6BC9E2);
  final String normalmsg = "Don't have an account? ";
  final String registerButtonText = "Register";

  final accountLoginTextStyle = TextStyle(
    height: 1.2,
    fontSize: 26.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.bold,
    color: Color(0xFF1F1F1F),
  );

  final labelTextStyle = TextStyle(
    height: 1.6,
    fontSize: 20.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.w600,
    color: Color(0xFF1F1F1F),
  );

  final forgotPasswordStyle = TextStyle(
      fontFamily: "Hind",
      fontWeight: FontWeight.w600,
      color: Color(0xFF4EABCC));

  final normalMsgStyle = TextStyle(
    fontSize: 16.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.w600,
    color: Color(0xFF1F1F1F),
  );

  final registerTextStyle = TextStyle(
    fontSize: 16.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.w600,
    color: Color(0xFF4EABCC),
  );

  TextStyle buttonLabelTextStyle({required Color textColor}) {
    return TextStyle(
      color: textColor,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: logoTop),
                  child: Column(
                    children: [
                      ImportLogo(width: logoWidth, height: logoHeight)
                          .importLogowo(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: accLogin_emailText),
                              child: Text(
                                accountLoginText,
                                style: accountLoginTextStyle,
                              ),
                            ),
                          ),
                          Text(
                            emailText,
                            style: labelTextStyle,
                          ),
                          GrayTextfield(
                            hintText: emailHint,
                            topPadding: topPadding,
                            bottomPadding: bottomPadding,
                          ),
                          Text(
                            passwordText,
                            style: labelTextStyle,
                          ),
                          GrayTextfield(
                            hintText: passwordHint,
                            topPadding: topPadding,
                            bottomPadding: bottomPadding,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                forgotPasswordText,
                                style: forgotPasswordStyle,
                              ),
                            ),
                          ),
                          InfiniteRoundWidthButton(
                            onPress: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                              );
                            },
                            buttonLabel: Text(
                              loginText,
                              style: buttonLabelTextStyle(
                                  textColor: loginTextColor),
                            ),
                            verticalMargin: verticalButtonMargin,
                            height: buttonHeight,
                            highlightColor: loginRegisterHighlightColor,
                            splashColor: loginRegisterSplashColor,
                            horizontalMargin: horizontalMargin,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                normalmsg,
                                style: normalMsgStyle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  registerButtonText,
                                  style: registerTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
