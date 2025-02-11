import 'package:chronicles/utilities/components/todo/todo.dart';
import 'package:flutter/material.dart';

import 'package:chronicles/services/todo_services.dart';

class Top3ToDoList extends StatefulWidget {
  Top3ToDoList({super.key});

  @override
  State<Top3ToDoList> createState() => _Top3ToDoListState();
}

class _Top3ToDoListState extends State<Top3ToDoList> {
  final ToDoDatabaseService _todoDB = ToDoDatabaseService.instance;
  List<ToDo> todos = [];
  bool _isLoading = true;

  void _updateTodoStatus(int index, int status) async {
    await _todoDB.updateTodoStatus(todos[index].index, status);
    setState(() {
      todos[index].status = status;
    });
  }

  Future<void> _loadTodos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      todos = await _todoDB.fetchTop3ToDos();
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
    return Container(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : todos.isEmpty
              ? const Center(child: Text('Nothing To Do'))
              : ListView.builder(
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
                ),
    );
  }
}
