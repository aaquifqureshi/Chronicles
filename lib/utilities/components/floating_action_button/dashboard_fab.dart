import 'package:flutter/material.dart';

import 'package:chronicles/screens/shared_diaries/view_shared_diaries.dart';
import 'package:chronicles/screens/text_editor/chronicles_text_editor.dart';
import 'package:chronicles/utilities/components/floating_action_button/navigate_floating_button.dart';

class DashboardFab extends StatelessWidget {
  const DashboardFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 220,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(76, 0, 0, 0),
              offset: const Offset(0, 5),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ]),
      child: Row(
        children: [
          NavigateFloatingButton(
            buttonPadding: EdgeInsets.fromLTRB(9.5, 6, 5, 6),
            buttonIcon: Icons.home,
            buttonIconColor: Color(0xFF4EABCC),
            buttonBackgroundColor: Color(0xFFE0F2FC),
            buttonHeroTag: 'home_button',
            isDisabled: true,
          ),
          NavigateFloatingButton(
            buttonPadding: EdgeInsets.fromLTRB(0, 6, 5, 6),
            buttonIcon: Icons.create_outlined,
            buttonIconColor: Color(0xFF797C7D),
            buttonBackgroundColor: Color(0xFFFFFFFF),
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
            buttonIconColor: Color(0xFF797C7D),
            buttonBackgroundColor: Color(0xFFFFFFFF),
            buttonHeroTag: 'user_button',
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ViewSharedDiaries(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
