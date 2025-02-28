import 'package:flutter/material.dart';

import '../../utilities/components/buttons/infinite_width_button.dart';
import '../../utilities/components/textfields/gray_textfield.dart';

final String passwordResetText = 'Set new password';
final String normalMessageText = 'Must be at least 8 characters.';
final String passwordHint = 'Enter password';
final String confirmPasswordHint = 'Enter password';
final String passwordText = 'Password';
final String confirmPasswordText = 'Confirm Password';
final String ResetPasswordButtonText = 'Reset Password';
final double iconSize = 80;
final double verticalButtonMargin = 30.0;
final double buttonHeight = 50.0;
final double horizontalMargin = 0.0;
final double topPadding = 0;
final double bottomPadding = 13;
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
  fontSize: 16.0,
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
TextEditingController newPassword = TextEditingController();
TextEditingController confirmNewPassword = TextEditingController();

void clearTextFields() {
  newPassword.clear();
  confirmNewPassword.clear();
}

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        clearTextFields();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25,top: 60),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Color(0xFFDDDFE5), width: 2),
                          ),
                          child:
                          Icon(Icons.fingerprint,size:iconSize),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 15,bottom: 42),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                passwordResetText,
                                style: passwordResetTextStyle,
                              ),
                              Text(
                                normalMessageText,
                                style: normalMessageStyle,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Text(
                        passwordText,
                        style: labelTextStyle,
                      ),
                      GrayTextfield(
                        controller: newPassword,
                        hintText: passwordHint,
                        topPadding: topPadding,
                        bottomPadding: bottomPadding,
                      ),

                      Text(
                        confirmPasswordText,
                        style: labelTextStyle,
                      ),
                      GrayTextfield(
                        controller: confirmNewPassword,
                        hintText: confirmPasswordHint,
                        topPadding: topPadding,
                        bottomPadding: bottomPadding,
                        isPassword: true,
                      ),

                      InfiniteRoundWidthButton(
                        onPress: () {
                          clearTextFields();
                          Navigator.pop(context);
                        },
                        buttonLabel: Text(
                          ResetPasswordButtonText,
                          style:
                          buttonLabelTextStyle(textColor: loginTextColor),
                        ),
                        verticalMargin: verticalButtonMargin,
                        height: buttonHeight,
                        highlightColor: loginRegisterHighlightColor,
                        splashColor: loginRegisterSplashColor,
                        horizontalMargin: horizontalMargin,
                      ),
                    ],
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
