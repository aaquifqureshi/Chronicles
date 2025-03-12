/*
* File Name        : view_shared_diaries.dart
* Group            : trOlsz Group
* Description      : This file is has code for Shared Diary Screen
*                    where users can publicly show their writings.
*/

import 'package:flutter/material.dart';

import '../../utilities/components/floating_action_button/navigate_floating_button.dart';

import '../text_editor/chronicles_text_editor.dart';

final double containerHeight = 55.0;
final double containerWidth = 220.0;
final EdgeInsetsGeometry containerMargin = EdgeInsets.only(bottom: 10);
final Color buttonBackgroundColor = Color(0xFFFFFFFF);
final Color shadowColor = Color.fromARGB(76, 0, 0, 0);
final BoxShadow boxShadow = BoxShadow(
  color: shadowColor,
  offset: Offset(0, 5),
  blurRadius: 15,
  spreadRadius: 0,
);
final Color buttonIconColorDefault = Color(0xFF797C7D);
final Color buttonIconColorUser = Color(0xFF4EABCC);
final Color buttonBackgroundColorUser = Color(0xFFE0F2FC);

class ViewSharedDiaries extends StatelessWidget {
  const ViewSharedDiaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: containerHeight,
        width: containerWidth,
        margin: containerMargin,
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [boxShadow],
        ),
        child: Row(
          children: [
            NavigateFloatingButton(
              buttonPadding: EdgeInsets.fromLTRB(9.5, 6, 5, 6),
              buttonIcon: Icons.home,
              buttonIconColor: buttonIconColorDefault,
              buttonBackgroundColor: buttonBackgroundColor,
              buttonHeroTag: 'home_button',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            NavigateFloatingButton(
              buttonPadding: EdgeInsets.fromLTRB(0, 6, 5, 6),
              buttonIcon: Icons.create_outlined,
              buttonIconColor: buttonIconColorDefault,
              buttonBackgroundColor: buttonBackgroundColor,
              buttonHeroTag: 'create_button',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextEditor(
                      isModify: false,
                    ),
                  ),
                );
              },
            ),
            NavigateFloatingButton(
              buttonPadding: EdgeInsets.fromLTRB(0, 6, 9.5, 6),
              buttonIcon: Icons.person,
              buttonIconColor: buttonIconColorUser,
              buttonBackgroundColor: buttonBackgroundColorUser,
              buttonHeroTag: 'user_button',
              isDisabled: true,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: AppBar(
        title: Text("Shared Diaries"),
      ),
    );
  }
}
