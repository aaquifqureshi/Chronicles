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

TextStyle authAlertButtonStyle = TextStyle(
  fontFamily: 'Hind',
  color: Color(0xFFFFFFFF),
  fontSize: 20,
);

TextStyle authAlertTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w600,
  color: Color(0xFF1F1F1F),
);

void authAlert(BuildContext context, {String msg = "", IconData? icon}) {
  Alert(
    context: context,
    title: "Error",
    desc: msg,
    style: authAlertStyle,
    // Error :
    // I tried to put multiple icons in the alert but due to desc the text was printing before the icon.
    // order it was printing : desc -> icon -> button
    // order I wanted : icon -> desc(Text) -> button

    // content: Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Icon(
    //       icon ?? Icons.warning,
    //       size: 50,
    //       color: Colors.red,
    //     ),
    //     SizedBox(height: 10),
    //     Text(
    //       msg,
    //       style: authAlertTextStyle,
    //     ),
    //   ],
    // ),
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: Color(0xFF4EABCC),
        child: Text(
          "Try Again!",
          style: authAlertButtonStyle,
        ),
      ),
    ],
  ).show();
}
