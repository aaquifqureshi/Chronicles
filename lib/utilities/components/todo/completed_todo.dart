import 'package:chronicles/utilities/components/todo/checkbox_with_label.dart';
import 'package:flutter/material.dart';

class CompletedTodo extends StatefulWidget {
  CompletedTodo({super.key});

  @override
  State<CompletedTodo> createState() => _CompletedTodoState();
}

class _CompletedTodoState extends State<CompletedTodo> {
  List<CheckboxWithLabel> listCompletedTodo = [
    CheckboxWithLabel(
      label: 'A',
      index: 1,
      checkboxValue: true,
    ),
    CheckboxWithLabel(
      label: 'B',
      index: 2,
      checkboxValue: true,
    ),
    CheckboxWithLabel(
      label: 'C',
      index: 3,
      checkboxValue: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed ToDo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: listCompletedTodo,
        ),
      ),
    );
  }
}
