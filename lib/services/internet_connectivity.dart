import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

Color iconColor = Color(0xFF4EABCC);
Icon connectionTrueIcon = Icon(
  Icons.wifi,
  color: iconColor,
);
Icon connectionFalseIcon = Icon(
  Icons.wifi_off,
  color: iconColor,
);

class InternetConnectionStatus extends StatefulWidget {
  const InternetConnectionStatus({super.key});

  @override
  State<InternetConnectionStatus> createState() =>
      _InternetConnectionStatusState();
}

class _InternetConnectionStatusState extends State<InternetConnectionStatus> {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return internetConnectionStatusIcon(_connectionStatus);
  }

  Icon internetConnectionStatusIcon(connectionStatus) {
    return connectionStatus == InternetStatus.connected
        ? connectionTrueIcon
        : connectionFalseIcon;
  }

  bool getInternetStatus() {
    return _connectionStatus == InternetStatus.connected ? true : false;
  }
}
