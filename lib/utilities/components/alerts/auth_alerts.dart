import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:flutter/material.dart';

final alertCircularRadius = 6.0;
final iconSize = 70.0;
final buttonHeight = 40.0;
final buttonCircularBorderRadius = 6.0;
final buttonVerticalPadding = 0.0;
final buttonHorizontalMargin = 0.0;
final Color buttonTextColor = Color(0xFFFFFFFF);
final Color buttonHighlightColor = Color(0xFF35879F);
final Color buttonSplashColor = Color(0xFF6BC9E2);

final authAlertTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w500,
  color: Color(0xFF1F1F1F),
);

TextStyle buttonLabelTextStyle({required Color textColor}) {
  return TextStyle(
    color: textColor,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 0.5,
  );
}

void authAlert(BuildContext context,
    {
      String message = "",
      String buttonText = "Try Again!",
      IconData? icon,
      Color iconColor = Colors.red,
    })
{
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(alertCircularRadius),
        ),

        title: Icon(icon ?? Icons.error,
          color: iconColor,
          size: iconSize,
        ),

        content: Text(message,
          style: authAlertTextStyle,
          textAlign: TextAlign.center,
        ),

        actions: [
          InfiniteRoundWidthButton(onPress: () {
            Navigator.pop(context);
          },
            buttonLabel: Text(
              buttonText,
              style: buttonLabelTextStyle(textColor: buttonTextColor),
            ),
            verticalPadding: buttonVerticalPadding,
            horizontalMargin: buttonHorizontalMargin,
            circularBorderRadius: buttonCircularBorderRadius,
            height: buttonHeight,
            highlightColor: buttonHighlightColor,
            splashColor: buttonSplashColor,
          ),
        ],
      );
    },
  );
}
