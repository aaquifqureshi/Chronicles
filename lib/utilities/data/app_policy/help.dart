/*
* File Name        : help.dart
* Group            : trOlsz Group
* Description      : This file contains code for HELP FAQ.
*/

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

String frequentlyAskedQuestions = """
   ## 1. How do I get started?
   Begin by creating an account
       
   ## 2. How to reset password?
   Go to settings ...
       
   ## 3. Contact support:
   Email: chroniclesbytrolsz@gmail.com
       
   ## 4. Troubleshooting:
   Check internet connection
   Clear app cache...
       
   ## 5. How do I add friends?:
   Look for your friend(s)' username
   Click 'Add friend'
       
   ## 6. How do I change diary state?:
   Select your diary
   Change diary state
       
   ## 7. How do I backup?:
   Go to settings
   Select local/cloud backup
       
   ## 8. Privacy policy:
   Data collection details...
       
   ## 9. About us:
   trOlsz Group :
   
     1. Malav Shah [Prompt Engineer] 
     2. Asgar Datari [UIUX Designer]
     3. Aaquif Qureshi [Full Stack Developer, Firebase Engineer]
     4. Mrunal Shah [Backend Developer, Database Engineer]
 """;

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      title: Text(
        "Frequently Asked Questions:\n",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF4EABCC),
          fontFamily: 'Hind',
        ),
      ),
      content: SizedBox(
        height: 300,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarkdownBody(
                  data: frequentlyAskedQuestions,
                  styleSheet: MarkdownStyleSheet(
                    codeblockDecoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    p: TextStyle(
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Close",
            style: TextStyle(
              color: Color(
                0xFF4EABCC,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
