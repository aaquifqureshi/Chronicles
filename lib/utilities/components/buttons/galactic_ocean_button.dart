import 'package:flutter/material.dart';

class GalacticOceanButton extends StatelessWidget {
  final void Function()? onPress;
  final Widget buttonLabel;
  final double horizontalMargin;

  const GalacticOceanButton({
    super.key,
    this.horizontalMargin = 0,
    required this.onPress,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: MaterialButton(
        padding: EdgeInsets.all(10.0),
        color: Color(0xFF4EABCC),
        onPressed: onPress,
        child: buttonLabel,
      ),
    );
  }
}
