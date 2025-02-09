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

import 'package:chronicles/services/internet_connectivity.dart';
import 'package:chronicles/services/login_auth.dart';
import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:chronicles/utilities/components/textfields/gray_textfield.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:flutter/material.dart';

import '../../utilities/components/alerts/auth_alerts.dart';
import '../../utilities/components/alerts/no_internet_alert.dart';

final double logoWidth = 130.0;
final double logoHeight = 130.0;
final double logoTop = 15.0;
final double accLoginEmailText = 40.0;
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
    fontFamily: "Hind", fontWeight: FontWeight.w600, color: Color(0xFF4EABCC));

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

class LoginScreen extends StatelessWidget {
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InternetConnectionStatus(),
                  ),
                ],
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
                            padding: EdgeInsets.only(bottom: accLoginEmailText),
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
                          controller: login_email,
                          hintText: emailHint,
                          topPadding: topPadding,
                          bottomPadding: bottomPadding,
                        ),
                        Text(
                          passwordText,
                          style: labelTextStyle,
                        ),
                        GrayTextfield(
                          controller: login_password,
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
                          onPress: () async {
                            var authValue = await loginAuthentication(
                              context,
                              login_email.text.trim(),
                              login_password.text.trim(),
                            );
                            bool hasInternet = await getInternetStatus();
                            if (hasInternet == true) {
                              if (authValue == 'true') {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/Dashboard',
                                  (Route<dynamic> route) => false,
                                );
                              } else if (authValue == "emptyFields") {
                                authEmptyFieldAlert(context);
                              } else if (authValue == "invalidCredentials") {
                                authSpecificAlert(
                                    context, "Email or Password is wrong");
                              } else if (authValue == 'unexpectedError') {
                                authSpecificAlert(
                                    context, "Unexpected Error Occured");
                              }
                            } else {
                              noInternetAlert(context);
                            }
                          },
                          buttonLabel: Text(
                            loginText,
                            style:
                                buttonLabelTextStyle(textColor: loginTextColor),
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
                                Navigator.popAndPushNamed(context, '/Register');
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
    );
  }
}
