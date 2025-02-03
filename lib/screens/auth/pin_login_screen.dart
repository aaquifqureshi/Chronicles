import 'package:chronicles/services/internet_connectivity.dart';
import 'package:flutter/material.dart';

class PinLoginScreen extends StatefulWidget {
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
