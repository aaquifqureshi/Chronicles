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

class ImportLogo {
  double width = 20.0;
  double height = 20.0;

  ImportLogo({required this.height, required this.width});

  Image importLogowo() {
    return Image.asset(
      'assets/images/logo/logowo.png',
      width: width,
      height: height,
    );
  }

  Image importLogow() {
    return Image.asset(
      'assets/images/logo/logow.png',
      width: width,
      height: height,
    );
  }
}

class ImageImport {
  double width = 20.0;
  double height = 20.0;

  ImageImport({required this.width, required this.height});

  Image importProfileIcon() {
    return Image.asset(
      'assets/images/build/profile_icon.png',
      width: width,
      height: height,
    );
  }

  Image importAddIcon() {
    return Image.asset(
      'assets/images/build/add_icon.png',
      width: width,
      height: height,
    );
  }
}
