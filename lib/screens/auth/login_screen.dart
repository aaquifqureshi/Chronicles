/* D
* File Name        : login_screen.dart
* Group            : trOlsz Group
* Description      : The File has Login Screen Code.
*
* NOTE : CODE IS UNSAFE AS WE ARE HARDCORE EMBEDDING THE
*        VALUES FOR AUTH.
*/

// Import Packages
import 'package:flutter/material.dart';
import 'package:chronicles/screens/auth/forgot_password_screen.dart';
import 'package:chronicles/services/internet_connectivity.dart';
import 'package:chronicles/services/login_auth.dart';
import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:chronicles/utilities/components/textfields/gray_textfield.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:chronicles/utilities/components/alerts/auth_alerts.dart';
import 'package:chronicles/utilities/components/alerts/no_internet_alert.dart';
import 'package:chronicles/services/pfp_services.dart';

// Logo Values
final double logoWidth = 130.0;
final double logoHeight = 130.0;
final double logoTop = 15.0;
final double logoLeft = 25.0;
final double logoRight = 25.0;
final double accLoginEmailText = 40.0;
final double topPadding = 0;
final double bottomPadding = 18;

// Variable Values & TextStyles
final double overallPadding = 25.0;
final double rightPaddingInternetConnectionIcon = 20.0;

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

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

void clearTextFields() {
  email.clear();
  password.clear();
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: rightPaddingInternetConnectionIcon,
                    ),
                    child: InternetConnectionStatus(),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: logoLeft, right: logoRight, top: logoTop),
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
                          controller: email,
                          hintText: emailHint,
                          topPadding: topPadding,
                          bottomPadding: bottomPadding,
                        ),
                        Text(
                          passwordText,
                          style: labelTextStyle,
                        ),
                        GrayTextfield(
                          controller: password,
                          hintText: passwordHint,
                          topPadding: topPadding,
                          bottomPadding: bottomPadding,
                          isPassword: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
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
                              email.text.trim(),
                              password.text.trim(),
                            );
                            bool hasInternet = await getInternetStatus();
                            if (context.mounted) {
                              if (hasInternet == true) {
                                if (authValue == 'true') {
                                  await updateSaveImage();
                                  await getSavedImagePath();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/Dashboard',
                                    (Route<dynamic> route) => false,
                                  );
                                } else if (authValue == "emptyFields") {
                                  authAlert(context,
                                      message: "Fields cannot be empty",
                                      icon: Icons.error_outline);
                                } else if (authValue == "invalidEmailSyntax") {
                                  authAlert(context,
                                      message: "Invalid Email Syntax",
                                      icon: Icons.warning_amber,
                                      iconColor: Colors.orangeAccent);
                                } else if (authValue == "invalidCredentials") {
                                  authAlert(context,
                                      message: "Email or Password is wrong",
                                      icon: Icons.error_outline);
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
                                clearTextFields();
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
