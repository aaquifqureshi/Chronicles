import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AlertStyle authAlertStyle = AlertStyle(
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

TextStyle authAlertTextStyle = TextStyle(
  fontFamily: 'Hind',
  color: Color(0xFFFFFFFF),
  fontSize: 20,
);

void authEmptyFieldAlert(BuildContext context) {
  Alert(
    context: context,
    title: "Error!",
    desc: "Fields cannot be empty",
    style: authAlertStyle,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: Color(0xFF4EABCC),
        child: Text(
          "Try Again!",
          style: authAlertTextStyle,
        ),
      ),
    ],
  ).show();
}

void authSpecificAlert(BuildContext context, String msg) {
  Alert(
    context: context,
    title: "Error!",
    desc: msg,
    style: authAlertStyle,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: Color(0xFF4EABCC),
        child: Text(
          "Try Again!",
          style: authAlertTextStyle,
        ),
      ),
    ],
  ).show();
}
