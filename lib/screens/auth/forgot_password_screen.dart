import 'package:chronicles/utilities/components/alerts/auth_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utilities/components/buttons/infinite_width_button.dart';
import '../../utilities/components/textfields/gray_textfield.dart';

final String passwordResetText = 'Password Reset ?';
final String normalMessageText = 'We’ll send you reset instructions.';
final String emailHint = 'Enter your email';
final String emailText = 'Email';
final String ResetButtonText = 'Reset';
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
TextEditingController verify_email = TextEditingController();
void clearTextFields() {
  verify_email.clear();
}

class ForgotPasswordScreen extends StatelessWidget {
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

                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(passwordResetText,
                            style: passwordResetTextStyle,),
                        ),
                      ),
                      Center(
                        child: Text(normalMessageText,
                            style: normalMessageStyle),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 42.0),
                        child: Text(
                          emailText,
                          style: labelTextStyle,
                        ),
                      ),
                      GrayTextfield(
                        controller: verify_email,
                        hintText: emailHint,
                        topPadding: topPadding,
                        bottomPadding: bottomPadding,
                      ),

                      InfiniteRoundWidthButton(
                        onPress: () async {
                          String email = verify_email.text.trim();
                          if (email.isEmpty) {
                            authAlert(context,message: "Please enter Email",icon: Icons.warning_amber,iconColor: Colors.orangeAccent);
                            return;
                          }
                          try {
                            var userDoc = await FirebaseFirestore.instance.collection("user_account").where("user_email", isEqualTo: email).get();

                            if (userDoc.docs.isNotEmpty) {
                              clearTextFields();
                              Navigator.popAndPushNamed(context, '/ChangePassword');
                            } else {
                              authAlert(context, message: "Email not found", icon: Icons.error);
                            }
                          }catch (e) {
                            authAlert(context, message: "Something went wrong", icon: Icons.error);
                          }
                        },
                        buttonLabel: Text(
                          ResetButtonText,
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
