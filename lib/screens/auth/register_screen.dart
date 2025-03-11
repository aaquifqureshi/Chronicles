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
import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:chronicles/utilities/components/textfields/gray_textfield.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:flutter/material.dart';

import '../../services/register_auth.dart';
import '../../utilities/components/alerts/auth_alerts.dart';
import '../../utilities/components/alerts/no_internet_alert.dart';
import '../../utilities/data/terms_and_conditions.dart';
import '../../utilities/data/privacy_policy.dart';

final double rightPadding = 25.0;
final double leftPadding = 25.0;
final double logoWidth = 130.0;
final double logoHeight = 130.0;
final double logoTop = 15.0;
final double topPadding = 0;
final double bottomPadding = 12.0;

final String createAccountText = 'Create Account';
final String firstNameHint = 'First Name';
final String lastNameHint = 'Last Name';
final String emailHint = 'Email';
final String passwordHint = 'Password';
final String normalMeassageText = 'By Signing up you agree to our ';
final String termsConditionText = 'Terms & Conditions';
final String privacyPolicyText = 'Privacy Policy';

final String signUpText = 'Sign Up';
final double verticalButtonMargin = 20.0;
final double buttonHeight = 50.0;
final double horizontalMargin = 0.0;
final Color signUpTextColor = Color(0xFFFFFFFF);
final Color loginRegisterHighlightColor = Color(0xFF35879F);
final Color loginRegisterSplashColor = Color(0xFF6BC9E2);
final String accountExistText = "Already have an account? ";
final String loginButttonText = "Login";

final createAccountStyle = TextStyle(
  height: 1.2,
  fontSize: 26.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.bold,
  color: Color(0xFF1F1F1F),
);

final normalMeassageTextStyle = TextStyle(
  fontSize: 14.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w400,
  color: Color(0xFF1F1F1F),
);

final gestureButtonStyle = TextStyle(
  fontSize: 14.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.bold,
  color: Color(0xFF4EABCC),
);

final accountExistStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w600,
  color: Color(0xFF1F1F1F),
);

final loginButtonStyle = TextStyle(
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

TextEditingController register_firstName = TextEditingController();
TextEditingController register_lastName = TextEditingController();
TextEditingController register_email = TextEditingController();
TextEditingController register_password = TextEditingController();

void clearTextFields() {
  register_firstName.clear();
  register_lastName.clear();
  register_email.clear();
  register_password.clear();
}

class RegisterScreen extends StatelessWidget {
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
                        clearTextFields();
                        Navigator.pop(context);
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
                padding: EdgeInsets.only(
                    left: leftPadding, right: rightPadding, top: logoTop),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImportLogo(width: logoWidth, height: logoHeight)
                        .importLogowo(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            createAccountText,
                            style: createAccountStyle,
                          ),
                        ),
                        GrayTextfield(
                          controller: register_firstName,
                          hintText: firstNameHint,
                          topPadding: 41,
                          bottomPadding: bottomPadding,
                        ),
                        GrayTextfield(
                          controller: register_lastName,
                          hintText: lastNameHint,
                          topPadding: topPadding,
                          bottomPadding: bottomPadding,
                        ),
                        GrayTextfield(
                          controller: register_email,
                          hintText: emailHint,
                          topPadding: topPadding,
                          bottomPadding: bottomPadding,
                        ),
                        GrayTextfield(
                          controller: register_password,
                          hintText: passwordHint,
                          topPadding: topPadding,
                          isPassword: true,
                          bottomPadding: 13,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          normalMeassageText,
                          style: normalMeassageTextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TermsAndConditionsScreen(),
                              ),
                            );
                          },
                          child: Text(
                            termsConditionText,
                            style: gestureButtonStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "& ",
                          style: normalMeassageTextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicyScreen(),
                              ),
                            );
                          },
                          child: Text(
                            privacyPolicyText,
                            style: gestureButtonStyle,
                          ),
                        ),
                      ],
                    ),
                    InfiniteRoundWidthButton(
                      onPress: () async {
                        var authValue = await registerAuthentication(
                          context,
                          register_firstName.text.trim(),
                          register_lastName.text.trim(),
                          register_email.text.trim(),
                          register_password.text.trim(),
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
                            authAlert(context,
                                message: "Fields cannot be empty",
                                icon: Icons.error_outline);
                          } else if (authValue == "emailAlreadyUsed") {
                            authAlert(context,
                                message: "Email Already in use.",
                                icon: Icons.warning_amber,
                                iconColor: Colors.orangeAccent);
                          } else if (authValue == "invalidEmailSyntax") {
                            authAlert(context,
                                message: "Invalid Email syntax.",
                                icon: Icons.warning_amber,
                                iconColor: Colors.orangeAccent);
                          } else if (authValue == 'unexpectedError') {
                            authAlert(context,
                                message: "Unexpected Error Occured",
                                icon: Icons.error_outline);
                          }
                        } else {
                          noInternetAlert(context);
                        }
                      },
                      buttonLabel: Text(
                        signUpText,
                        style: buttonLabelTextStyle(textColor: signUpTextColor),
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
                          accountExistText,
                          style: accountExistStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            clearTextFields();
                            Navigator.popAndPushNamed(context, '/Login');
                          },
                          child: Text(
                            loginButttonText,
                            style: loginButtonStyle,
                          ),
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
