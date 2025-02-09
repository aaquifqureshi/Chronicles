import 'package:flutter/cupertino.dart';

import 'checkbox_with_label.dart';

class Top3ToDoList extends StatefulWidget {
  Top3ToDoList({super.key});

  List<CheckboxWithLabel> top3TodoList = [
    CheckboxWithLabel(
      label: 'A',
    ),
    CheckboxWithLabel(
      label: 'B',
    ),
    CheckboxWithLabel(
      label: 'C',
    ),
  ];

  @override
  State<Top3ToDoList> createState() => _Top3ToDoListState();
}

class _Top3ToDoListState extends State<Top3ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.top3TodoList,
    );
  }
}
