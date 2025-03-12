/* D
* File Name        : register_screen.dart
* Group            : trOlsz Group
* Description      : This file has code for the Register Screen
*
* NOTE : CODE IS UNSAFE AS WE ARE HARDCORE EMBEDDING THE
*        VALUES FOR AUTH.
*/

// Importing Packages
import 'package:flutter/material.dart';
import 'package:chronicles/services/internet_connectivity.dart';
import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:chronicles/utilities/components/textfields/gray_textfield.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:chronicles/services/register_auth.dart';
import 'package:chronicles/utilities/components/alerts/auth_alerts.dart';
import 'package:chronicles/utilities/components/alerts/no_internet_alert.dart';
import 'package:chronicles/utilities/data/app_policy/terms_and_conditions.dart';
import 'package:chronicles/utilities/data/app_policy/privacy_policy.dart';

// Variable Values & TextStyles
final double overallPadding = 25.0;

final double rightPadding = 25.0;
final double leftPadding = 25.0;
final double logoWidth = 130.0;
final double logoHeight = 130.0;
final double logoTop = 15.0;
final double firstTopPadding = 41.0;
final double topPadding = 0;
final double bottomPadding = 12.0;
final double lastBottomPadding = 13.0;
final double rightPaddingInternetConnectionIcon = 20.0;
final bool isPasswordVisible = true;

final String createAccountText = 'Create Account';
final String firstNameHint = 'First Name';
final String lastNameHint = 'Last Name';
final String emailHint = 'Email';
final String passwordHint = 'Password';
final String normalMeassageText = 'By Signing up you agree to our ';
final String termsConditionText = 'Terms & Conditions';
final String textBetweenTCandPrivayPolicy = "& ";
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

TextEditingController firstName = TextEditingController();
TextEditingController lastName = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

void clearTextFields() {
  firstName.clear();
  lastName.clear();
  email.clear();
  password.clear();
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: overallPadding),
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
                    padding: EdgeInsets.only(
                        right: rightPaddingInternetConnectionIcon),
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
                          controller: firstName,
                          hintText: firstNameHint,
                          topPadding: firstTopPadding,
                          bottomPadding: bottomPadding,
                        ),
                        GrayTextfield(
                          controller: lastName,
                          hintText: lastNameHint,
                          topPadding: topPadding,
                          bottomPadding: bottomPadding,
                        ),
                        GrayTextfield(
                          controller: email,
                          hintText: emailHint,
                          topPadding: topPadding,
                          bottomPadding: bottomPadding,
                        ),
                        GrayTextfield(
                          controller: password,
                          hintText: passwordHint,
                          topPadding: topPadding,
                          isPassword: isPasswordVisible,
                          bottomPadding: lastBottomPadding,
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
                          textBetweenTCandPrivayPolicy,
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
                          firstName.text.trim(),
                          lastName.text.trim(),
                          email.text.trim(),
                          password.text.trim(),
                        );
                        bool hasInternet = await getInternetStatus();
                        if (context.mounted) {
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
