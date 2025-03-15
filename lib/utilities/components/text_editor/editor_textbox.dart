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
    return GestureDetector(
      onTap: onToggleEdit,
      child: editMode
          ? Row(
              children: [
                Expanded(
                  child: TextField(
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
                      }),
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
