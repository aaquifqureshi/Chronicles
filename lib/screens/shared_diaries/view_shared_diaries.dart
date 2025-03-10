import 'package:flutter/material.dart';

import '../../utilities/components/buttons/custom_floatingbutton.dart';

import '../../utilities/components/text_editor/chronicles_text_editor.dart';

class ViewSharedDiaries extends StatelessWidget {
  const ViewSharedDiaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
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
              buttonIconColor: Color(0xFF797C7D),
              buttonBackgroundColor: Color(0xFFFFFFFF),
              buttonHeroTag: 'home_button',
              onPressed: () {
                Navigator.pop(context);
              },
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
              buttonIconColor: Color(0xFF4EABCC),
              buttonBackgroundColor: Color(0xFFE0F2FC),
              buttonHeroTag: 'user_button',
              isDisabled: true,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: AppBar(),
    );
  }
}
