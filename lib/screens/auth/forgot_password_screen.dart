/* D
* File Name        : forgot_password_screen.dart
* Group            : trOlsz Group
* Description      : This file has code for the Register Screen
*
* NOTE : clearTextFields Not Working.
*/

// Importing Packages
import 'package:chronicles/utilities/components/alerts/auth_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:chronicles/utilities/components/textfields/gray_textfield.dart';

// Variable Values & TextStyle
final double iconTopPadding = 20.0;
final double bodyLeftRightPadding = 25.0;
final double bodyTopPadding = 60.0;
final double borderRadiusFingerprint = 6.0;
final double borderWidthFingerprint = 2.0;
final double passwordResetTextTopPadding = 15.0;
final double emailTextTopPadding = 42.0;

final Color borderColorFingerprint = Color(0xFFDDDFE5);
final String passwordResetText = 'Password Reset ?';
final String normalMessageText = 'We’ll send you reset instructions.';
final String emailHint = 'Enter your email';
final String emailText = 'Email';
final String resetButtonText = 'Reset';
final double iconSize = 80;
final double verticalButtonMargin = 30.0;
final double buttonHeight = 50.0;
final double horizontalMargin = 0.0;
final double topPadding = 0;
final double bottomPadding = 18;
final Color loginTextColor = Color(0xFFFFFFFF);
final Color loginRegisterHighlightColor = Color(0xFF35879F);
final Color loginRegisterSplashColor = Color(0xFF6BC9E2);

final passwordResetTextStyle = TextStyle(
  height: 1.2,
  fontSize: 30.0,
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

final normalMessageStyle = TextStyle(
  fontSize: 15.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w500,
  color: Color(0xFF5B5A5A),
);

TextStyle buttonLabelTextStyle({required Color textColor}) {
  return TextStyle(
    color: textColor,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 0.5,
  );
}

TextEditingController verifyEmail = TextEditingController();
void clearTextFields() {
  verifyEmail.clear();
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            clearTextFields();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: bodyLeftRightPadding,
                right: bodyLeftRightPadding,
                top: bodyTopPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.circular(borderRadiusFingerprint),
                        border: Border.all(
                          color: borderColorFingerprint,
                          width: borderWidthFingerprint,
                        ),
                      ),
                      child: Icon(Icons.fingerprint, size: iconSize),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: passwordResetTextTopPadding),
                    child: Center(
                      child: Text(
                        passwordResetText,
                        style: passwordResetTextStyle,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(normalMessageText, style: normalMessageStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: emailTextTopPadding),
                    child: Text(
                      emailText,
                      style: labelTextStyle,
                    ),
                  ),
                  GrayTextfield(
                    controller: verifyEmail,
                    hintText: emailHint,
                    topPadding: topPadding,
                    bottomPadding: bottomPadding,
                  ),
                  InfiniteRoundWidthButton(
                    onPress: () async {
                      String email = verifyEmail.text.trim();
                      if (email.isEmpty) {
                        authAlert(context,
                            message: "Please enter Email",
                            icon: Icons.warning_amber,
                            iconColor: Colors.orangeAccent);
                        return;
                      }

                      try {
                        var userDoc = await FirebaseFirestore.instance
                            .collection("user_account")
                            .where("email", isEqualTo: email)
                            .get();
                        if (context.mounted) {
                          if (userDoc.docs.isNotEmpty) {
                            clearTextFields();
                            Navigator.popAndPushNamed(
                                context, '/ChangePassword');
                          } else {
                            authAlert(context,
                                message: "Email not found", icon: Icons.error);
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          authAlert(context,
                              message: "Something went wrong",
                              icon: Icons.error);
                        }
                      }
                    },
                    buttonLabel: Text(
                      resetButtonText,
                      style: buttonLabelTextStyle(textColor: loginTextColor),
                    ),
                    verticalMargin: verticalButtonMargin,
                    height: buttonHeight,
                    highlightColor: loginRegisterHighlightColor,
                    splashColor: loginRegisterSplashColor,
                    horizontalMargin: horizontalMargin,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
