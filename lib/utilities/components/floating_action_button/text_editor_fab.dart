import 'package:flutter/material.dart';

import 'package:chronicles/screens/shared_diaries/view_shared_diaries.dart';
import 'package:chronicles/screens/text_editor/chronicles_text_editor.dart';
import 'package:chronicles/utilities/components/floating_action_button/navigate_floating_button.dart';

class TextEditorFab extends StatelessWidget {
  Function() reactionFunction;
  Function() ttsFunction;
  Function() sttFunction;

  TextEditorFab(
      {super.key,
      required this.reactionFunction,
      required this.sttFunction,
      required this.ttsFunction});

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
            buttonIcon: Icons.add_reaction_rounded,
            buttonIconColor: Color(0xFF4EABCC),
            buttonBackgroundColor: Color(0xFFFFFFFF),
            buttonHeroTag: 'Add Reaction',
            onPressed: reactionFunction,
          ),
          NavigateFloatingButton(
            buttonPadding: EdgeInsets.fromLTRB(0, 6, 5, 6),
            buttonIcon: Icons.transcribe_rounded,
            buttonIconColor: Color(0xFF4EABCC),
            buttonBackgroundColor: Color(0xFFFFFFFF),
            buttonHeroTag: 'Text To Speech',
            onPressed: ttsFunction,
          ),
          NavigateFloatingButton(
            buttonPadding: EdgeInsets.fromLTRB(0, 6, 9.5, 6),
            buttonIcon: Icons.text_fields,
            buttonIconColor: Color(0xFF4EABCC),
            buttonBackgroundColor: Color(0xFFFFFFFF),
            buttonHeroTag: 'Speech to Text',
            onPressed: sttFunction,
          ),
        ],
      ),
    );
  }
}
