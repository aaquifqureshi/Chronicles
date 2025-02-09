/*
* File Name     : chronicles.dart
* Date Created  : 1st February 2025
* last Modified : 1st February 2025
* Author        : Aaquif Qureshi
* Group         : trOlsz Group
* Description   : This file is the start point in this app.
*                It runs the app and send it to the next Screen
*                based on the authentication requirements set by
*                the group.
*
*/

import 'package:flutter/material.dart';

class GrayTextfield extends StatelessWidget {
  final String hintText;
  final double topPadding;
  final double bottomPadding;
  final TextEditingController controller;

  const GrayTextfield({
    this.topPadding = 0,
    this.bottomPadding = 0,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hintStyle = TextStyle(
      color: Color(0xFF80858D),
      fontFamily: "Hind",
      fontWeight: FontWeight.w500,
    );

    final textFieldStyle = TextStyle(
      fontSize: 16.0,
      fontFamily: "Hind",
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: TextField(
        controller: controller,
        style: textFieldStyle,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          filled: true,
          fillColor: Color(0xFFF7F8FA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFFDDDFE5),
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFFDDDFE5),
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFFFDDDFE5),
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
