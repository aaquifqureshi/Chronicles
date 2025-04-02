import 'package:chronicles/utilities/components/text_editor/reaction_type_data.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/utilities/components/floating_action_button/navigate_floating_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextEditorFab extends StatelessWidget {
  Function() reactionFunction;
  Function() ttsFunction;
  Function() sttFunction;
  ReactionType reactionType;

  TextEditorFab({
    super.key,
    required this.reactionFunction,
    required this.sttFunction,
    required this.ttsFunction,
    required this.reactionType,
  });

  IconData fetchIcon() {
    if (reactionType == ReactionType.crying) {
      return FontAwesomeIcons.faceSadCry;
    } else if (reactionType == ReactionType.sad) {
      return FontAwesomeIcons.faceSadTear;
    } else if (reactionType == ReactionType.noSadNoHappy) {
      return FontAwesomeIcons.faceMeh;
    } else if (reactionType == ReactionType.smile) {
      return FontAwesomeIcons.faceSmile;
    } else if (reactionType == ReactionType.happy) {
      return FontAwesomeIcons.faceLaugh;
    }
    return Icons.add_reaction_rounded;
  }

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
            buttonIcon: fetchIcon(),
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
