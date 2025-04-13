/*
* File Name        : editor_textbox.dart
* Group            : trOlsz Group
* Description      : This file contains code for our text editor's
*                   text box.
*/

import 'package:flutter/material.dart';
import 'markdown_to_html.dart';

final textEditorStyle = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
);

class EditorTextBox extends StatelessWidget {
  final TextEditingController controller;
  final bool editMode;
  final void Function() onToggleEdit;
  final void Function() onDelete;

  const EditorTextBox({
    super.key,
    required this.controller,
    required this.editMode,
    required this.onToggleEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController imageController = TextEditingController();
    RegExp exp = RegExp(r'!\[([^\]]*)\]\(([^)]+)\)');
    bool isImage = exp.hasMatch(controller.text);
    RegExpMatch? match;

    if (isImage) {
      match = exp.firstMatch(controller.text);
      if (match != null && match.groupCount >= 1) {
        if (match.group(1) != 'Type Image Description Here') {
          imageController.text = match.group(1)!;
        } else {
          imageController.text = '';
        }
      }
    }

    return GestureDetector(
      onTap: onToggleEdit,
      child: editMode
          ? isImage
              ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        style: textEditorStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write Image Description!',
                        ),
                        maxLines: null,
                        controller: imageController,
                        onTapUpOutside: (event) {
                          if (isImage && match != null) {
                            final newText = controller.text.replaceRange(
                              match.start,
                              match.end,
                              '![${imageController.text}](${match.group(2)!})',
                            );
                            controller.text = newText;
                          }

                          onToggleEdit();
                        },
                        onTapOutside: (event) {
                          if (isImage && match != null) {
                            final newText = controller.text.replaceRange(
                              match.start,
                              match.end,
                              '![${imageController.text}](${match.group(2)!})',
                            );
                            controller.text = newText;
                          }

                          onToggleEdit();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            print('CROP');
                          },
                          icon: Icon(
                            Icons.crop,
                            color: Color(0xFF4EABCC),
                          ),
                        ),
                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(
                            Icons.delete,
                            color: Color(0xFF4EABCC),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: TextField(
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        style: textEditorStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write Your Journey!',
                        ),
                        controller: controller,
                        maxLines: null,
                        onTapUpOutside: (event) {
                          onToggleEdit();
                        },
                        onTapOutside: (event) {
                          onToggleEdit();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xFF4EABCC),
                      ),
                    ),
                  ],
                )
          : MarkdownToHtml(markdownText: controller.text),
    );
  }
}
