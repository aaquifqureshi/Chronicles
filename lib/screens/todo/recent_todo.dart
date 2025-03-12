/*
* File Name        : recent_todo.dart
* Group            : trOlsz Group
* Description      : This file is has code for To-Do Component
*                    which can show top x To-do task.
*/

import 'package:chronicles/utilities/components/todo/todo.dart';
import 'package:flutter/material.dart';

import 'package:chronicles/services/todo_services.dart';

class RecentToDo extends StatefulWidget {
  const RecentToDo({super.key});

  @override
  State<RecentToDo> createState() => _RecentToDoState();
}

class _RecentToDoState extends State<RecentToDo> {
  final ToDoDatabaseService _todoDB = ToDoDatabaseService.instance;
  List<ToDo> todos = [];
  bool _isLoading = true;

  void _updateTodoStatus(int index, int status) async {
    await _todoDB.updateTodoStatus(todos[index].id, status);
    setState(() {
      todos[index].status = status;
    });
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      todos = await _todoDB.fetchRecentToDos(limitRecentToDo: 3);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : todos.isEmpty
            ? SizedBox(
                height: double.minPositive + 25,
                child: Center(
                  child: Text(
                    'Nothing To Do',
                    style: TextStyle(
                      fontFamily: "Hind",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0x40000000),
                    ),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  ToDo todo = todos[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            value: todo.status == 1,
                            onChanged: (value) {
                              setState(() {
                                todo.status = value! ? 1 : 0;
                                _updateTodoStatus(index, todo.status);
                                _loadTodos();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Text(todo.content),
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}
