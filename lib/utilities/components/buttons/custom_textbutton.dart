/*
* File Name        : custom_textbutton.dart
* Group            : trOlsz Group
* Description      : This file is custom text button.
*/

import 'package:flutter/material.dart';

final buttonTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w600,
  color: Color(0xFF1F1F1F),
);

class CustomTextButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color containerColor;
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.icon,
    this.containerColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          overlayColor: Color(0xFF9b9b9b),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: Color(0xFF1F1F1F), size: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    text,
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF1F1F1F)),
          ],
        ),
      ),
    );
  }
}
