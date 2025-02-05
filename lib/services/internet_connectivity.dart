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
  late final StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();

    InternetConnection().hasInternetAccess.then((hasInternet) {
      setState(() {
        _connectionStatus = hasInternet
            ? InternetStatus.connected
            : InternetStatus.disconnected;
      });
    });

    _subscription = InternetConnection().onStatusChange.listen((status) {
      if (mounted) {
        setState(() {
          _connectionStatus = status;
        });
      }
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

  Widget internetConnectionStatusIcon(connectionStatus) {
    if (connectionStatus == null) {
      return SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            iconColor,
          ),
          strokeWidth: 2,
        ),
      );
    }
    return connectionStatus == InternetStatus.connected
        ? connectionTrueIcon
        : connectionFalseIcon;
  }
}

Future<bool> getInternetStatus() async {
  bool result = await InternetConnection().hasInternetAccess;
  return result;
}
