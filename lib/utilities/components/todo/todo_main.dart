import 'package:chronicles/utilities/components/todo/checkbox_with_label.dart';
import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<CheckboxWithLabel> todoList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.drag_indicator),
                Expanded(
                  child: CheckboxWithLabel(label: 'Test'),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.drag_indicator),
                Expanded(
                  child: CheckboxWithLabel(label: 'Test'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
