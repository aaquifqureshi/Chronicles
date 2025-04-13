/*
* File Name        : markdown_to_html.dart
* Group            : trOlsz Group
* Description      : This file contains code for converting markdown
*                    to HTML.
*/

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownToHtml extends StatefulWidget {
  final String markdownText;

  const MarkdownToHtml({super.key, required this.markdownText});

  @override
  State<MarkdownToHtml> createState() => _MarkdownToHtmlState();
}

class _MarkdownToHtmlState extends State<MarkdownToHtml> {
  @override
  Widget build(BuildContext context) {
    return Markdown(
      shrinkWrap: true,
      data: widget.markdownText,
      physics: NeverScrollableScrollPhysics(),
      styleSheet: MarkdownStyleSheet(
        codeblockDecoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        p: TextStyle(
          backgroundColor: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
