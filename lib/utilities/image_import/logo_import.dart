/*
* File Name        : logo_import.dart
* Group            : trOlsz Group
* Description      : This file contains code for Logo Fetching from
*                    Assets.
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
      'assets/images/icons/new_profile_icon.png',
      width: width,
      height: height,
    );
  }

  Image importAddIcon() {
    return Image.asset(
      'assets/images/icons/add_icon.png',
      width: width,
      height: height,
    );
  }
}
