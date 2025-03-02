import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownToHtml extends StatefulWidget {
  late String markdownText;

  MarkdownToHtml({super.key, required this.markdownText});

  @override
  State<MarkdownToHtml> createState() => _MarkdownToHtmlState();
}

class _MarkdownToHtmlState extends State<MarkdownToHtml> {
  @override
  Widget build(BuildContext context) {
    return Markdown(
      shrinkWrap: true,
      data: widget.markdownText,
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
