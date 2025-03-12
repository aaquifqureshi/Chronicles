/*
* File Name        : todo_textfield.dart
* Group            : trOlsz Group
* Description      : This file contains code for custom textfield.
*/

import 'package:flutter/material.dart';

class ToDoTextField extends StatefulWidget {
  final String text;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEmptyDelete;

  const ToDoTextField({
    super.key,
    required this.text,
    this.onChanged,
    this.onEmptyDelete,
  });

  @override
  State<ToDoTextField> createState() => _ToDoTextFieldState();
}

class _ToDoTextFieldState extends State<ToDoTextField> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    if (widget.text == 'Enter Task') {
      _textController = TextEditingController();
    } else {
      _textController = TextEditingController(text: widget.text);
    }
  }

  @override
  void didUpdateWidget(covariant ToDoTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _textController.text = widget.text;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      style: TextStyle(
        fontFamily: "Hind",
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
      onChanged: widget.onChanged,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (_textController.text.trim().isEmpty) {
          widget.onEmptyDelete?.call();
        }
      },
      decoration: const InputDecoration(
        hintText: 'Enter a Task',
        hintStyle: TextStyle(
          fontFamily: "Hind",
          fontSize: 16,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
