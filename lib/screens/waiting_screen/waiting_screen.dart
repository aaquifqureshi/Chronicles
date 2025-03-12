/*
* File Name        : waiting_screen.dart
* Group            : trOlsz Group
* Description      : This file is has code for waiting Screen.
*/

import 'package:flutter/material.dart';

import 'package:chronicles/utilities/image_import/logo_import.dart';

Widget waitingScreen() {
  return Container(
    color: Color(0xFFFFFFFF),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImportLogo(height: 230, width: 230).importLogowo(),
        SizedBox(
          height: 20.0,
        ),
        CircularProgressIndicator(
          color: Color(0xFF4EABCC),
        ),
      ],
    ),
  );
}
