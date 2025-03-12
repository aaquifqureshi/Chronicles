/* D
* File Name        : register_screen.dart
* Group            : trOlsz Group
* Description      : This file has code for the Pin Login Screen
*/

import 'package:chronicles/services/internet_connectivity.dart';
import 'package:flutter/material.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InternetConnectionStatus(),
      ),
    );
  }
}
