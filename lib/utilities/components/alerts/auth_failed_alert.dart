import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AlertStyle authFailedAlertStyle = AlertStyle(
  backgroundColor: Color(0xFFFFFFFF),
  isCloseButton: false,
  descStyle: TextStyle(
    color: Color(0xFF1F1F1F),
  ),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
    side: BorderSide(
      color: Color(0xFF111519),
    ),
  ),
  titleStyle: TextStyle(
    fontFamily: 'Abyssinica_SIL',
    color: Color(0xFF4EABCC),
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
  ),
);

TextStyle authFailedAlertTextStyle = TextStyle(
  fontFamily: 'Hind',
  color: Color(0xFFFFFFFF),
  fontSize: 20,
);

void authFailedAlert(BuildContext context) {
  Alert(
    context: context,
    title: "Access Denied",
    desc: "Please check username and/or password...",
    style: authFailedAlertStyle,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: Color(0xFF4EABCC),
        child: Text(
          "Try Again!",
          style: authFailedAlertTextStyle,
        ),
      ),
    ],
  ).show();
}
