/*
* File Name        : navigate_floating_button.dart
* Group            : trOlsz Group
* Description      : This file is custom floating button.
*/

import 'package:flutter/material.dart';

class NavigateFloatingButton extends StatelessWidget {
  final EdgeInsets buttonPadding;
  final IconData buttonIcon;
  final Color buttonBackgroundColor;
  final Color buttonIconColor;
  final String buttonHeroTag;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const NavigateFloatingButton({
    super.key,
    required this.buttonPadding,
    required this.buttonIcon,
    required this.buttonBackgroundColor,
    required this.buttonIconColor,
    required this.buttonHeroTag,
    this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding,
      child: AbsorbPointer(
        absorbing: isDisabled,
        child: SizedBox(
          height: 43,
          width: 63,
          child: FloatingActionButton(
            heroTag: buttonHeroTag,
            backgroundColor: buttonBackgroundColor,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
            onPressed: isDisabled ? null : onPressed,
            child: Icon(
              buttonIcon,
              color: buttonIconColor,
            ),
          ),
        ),
      ),
    );
  }
}
