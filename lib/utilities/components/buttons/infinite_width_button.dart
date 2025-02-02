/*
* File Name     : chronicles.dart
* Date Created  : 28th January 2025
* last Modified : 28th January 2025
* Author        : Mrunal Nirajkumar Shah
* Group         : trOlsz Group
* Description   : This file is the start point in this app.
*                It runs the app and send it to the next Screen
*                based on the authentication requirements set by
*                the group.
*
*/

import 'package:flutter/material.dart';

class InfiniteRoundWidthButton extends StatelessWidget {
  final double horizontalMargin;
  final double verticalMargin;
  final double horizontalPadding;
  final double verticalPadding;
  final double height;
  final double elevationValue;
  final Color backgroundColor;
  final Color borderColor;
  final Color splashColor;
  final Color highlightColor;
  final double circularBorderRadius;
  final double borderWidth;
  final Widget buttonLabel;
  final void Function()? onPress;

  InfiniteRoundWidthButton({
    this.height = 50.0,
    this.horizontalMargin = 20.0,
    this.verticalMargin = 0.0,
    this.verticalPadding = 15,
    this.horizontalPadding = 0,
    this.elevationValue = 0,
    this.backgroundColor = const Color(0xFF4EABCC),
    this.highlightColor = const Color(0xFFD4D4D4),
    this.splashColor = const Color(0xFFBDBDBD),
    this.circularBorderRadius = 25,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
    required this.onPress,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      child: MaterialButton(
        onPressed: onPress,
        color: backgroundColor,
        splashColor: splashColor,
        highlightColor: highlightColor,
        elevation: elevationValue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius),
          side: BorderSide(color: borderColor, width: borderWidth),
        ),
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: buttonLabel,
      ),
    );
  }
}
