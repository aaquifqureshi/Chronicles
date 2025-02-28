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

class GrayTextfield extends StatefulWidget {
  final String hintText;
  final double topPadding;
  final double bottomPadding;
  final TextEditingController controller;
  final bool isPassword;

  const GrayTextfield({
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.isPassword = false,
    required this.hintText,
    required this.controller,
  });

  @override
  State<GrayTextfield> createState() => _GrayTextfieldState();
}

class _GrayTextfieldState extends State<GrayTextfield> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }
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
      padding: EdgeInsets.only(top: widget.topPadding, bottom: widget.bottomPadding),
      child: TextField(
        controller: widget.controller,
        style: textFieldStyle,
        obscureText: widget.isPassword ? obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
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
          suffixIcon: widget.isPassword ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Color(0xFF1F1F1F),
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ) : null,
        ),
      ),
    );
  }
}