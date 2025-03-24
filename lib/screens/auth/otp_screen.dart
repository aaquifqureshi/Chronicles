import 'package:chronicles/utilities/components/keyboard/blue_numeric_keyboard.dart';

import 'package:chronicles/utilities/components/textfields/otp_display_textfield.dart';

import 'package:flutter/material.dart';

final String passwordResetText = 'Password Reset';

final String normalMessageTitleText = 'We sent a code to your email';

final String normalMessageText = "Did not receive OTP? ";

final String resendButtonText = "Resend Code";

final double bodyLeftRightPadding = 25.0;

final double bodyTopPadding = 60.0;

final double iconContainerSize = 90.0;

final double containerRadius = 12.0;

final double iconSize = 80.0;

final double titleTopPadding = 20.0;

final double textFieldTopPadding = 50.0;

final double textFieldBottomPadding = 10.0;

final double resendTextTopPadding = 5.0;

final double resendTextBottomPadding = 15.0;

final Color borderColor = Color(0xFFDDDFE5);

final passwordResetTextStyle = TextStyle(
  height: 1.2,
  fontSize: 30.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w600,
  color: Color(0xFF1F1F1F),
);

final normalMessageTitleStyle = TextStyle(
  fontSize: 15.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w500,
  color: Color(0xFF5B5A5A),
);

final normalMessageStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w600,
  color: Color(0xFF1F1F1F),
);

final resentOtpButtonStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w600,
  color: Color(0xFF4EABCC),
);

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String inputText = "";

  void handleKeyTap(String key) {
    setState(() {
      if (key == "C") {
        inputText = "";
      } else if (key == "✔") {
        if (inputText == "1234") {
          Navigator.popAndPushNamed(context, '/ChangePassword');
        }
      } else {
        inputText += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
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
                    height: iconContainerSize,
                    width: iconContainerSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(containerRadius),
                      border: Border.all(
                        color: borderColor,
                        width: 2,
                      ),
                    ),
                    child: Icon(Icons.mail_outline, size: iconSize),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: titleTopPadding),
                  child: Center(
                    child: Text(
                      passwordResetText,
                      style: passwordResetTextStyle,
                    ),
                  ),
                ),
                Center(
                  child: Text(normalMessageTitleText,
                      style: normalMessageTitleStyle),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: textFieldTopPadding, bottom: textFieldBottomPadding),
                  child: OtpDisplayTextfield(inputText: inputText),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: resendTextTopPadding, bottom: resendTextBottomPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  normalMessageText,
                  style: normalMessageStyle,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    resendButtonText,
                    style: resentOtpButtonStyle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: CustomNumericKeyboard(onKeyTap: handleKeyTap)),
        ],
      ),
    );
  }
}
