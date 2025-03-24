import 'package:flutter/material.dart';

final double containerSize = 55.0;

final double horizontalMargin = 8.0;

final double borderRadius = 10.0;

final int numberOfTextFields = 4;

final Color borderColor = Color(0xFFDDDFE5);

final displayNumberTextStyle = TextStyle(
  fontSize: 26.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w600,
  color: Color(0xFF5B5A5A),
);

class OtpDisplayTextfield extends StatelessWidget {
  final String inputText;

  const OtpDisplayTextfield({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(numberOfTextFields, (index) {
          return Container(
            width: containerSize,
            height: containerSize,
            margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            alignment: Alignment.center,
            child: Text(
              index < inputText.length ? inputText[index] : "",
              style: displayNumberTextStyle,
            ),
          );
        }),
      ),
    );
  }
}
