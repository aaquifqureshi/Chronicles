import 'package:flutter/material.dart';
import 'package:chronicles/utilities/components/todo/todo.dart';
import 'package:chronicles/services/todo_services.dart';
import 'package:chronicles/utilities/components/textfields/todo_textfield.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final ToDoDatabaseService _todoDB = ToDoDatabaseService.instance;
  List<ToDo> pendingTodos = [];
  List<ToDo> completedTodos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() => _isLoading = true);
    try {
      pendingTodos = await _todoDB.fetchPendingToDoTasks();
      completedTodos = await _todoDB.fetchCompletedToDoTasks();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _updateTodo(int index, String newText, bool isCompleted) async {
    newText = newText.trim();

    List<ToDo> targetList = isCompleted ? completedTodos : pendingTodos;

    if (newText.isEmpty) {
      return;
    }

    await _todoDB.updateToDoTask(targetList[index].id, newText);
    setState(() {
      targetList[index].content = newText;
    });
  }

  void _updateTodoStatus(int index, bool isCompleted) async {
    List<ToDo> targetList = isCompleted ? completedTodos : pendingTodos;
    ToDo todo = targetList[index];

    await _todoDB.updateTodoStatus(todo.id, isCompleted ? 0 : 1);

    setState(() {
      if (isCompleted) {
        completedTodos.removeAt(index);
        pendingTodos.add(todo..status = 0);
      } else {
        pendingTodos.removeAt(index);
        completedTodos.add(todo..status = 1);
      }
    });
  }

  void _deleteTodo(int index, bool isCompleted) async {
    List<ToDo> targetList = isCompleted ? completedTodos : pendingTodos;

    if (index < 0 || index >= targetList.length) return;
    await _todoDB.deleteToDoTask(targetList[index].id);
    setState(() {
      targetList.removeAt(index);
    });
    for (int i = 0; i < targetList.length; i++) {
      targetList[i].index = i;
      await _todoDB.updateToDoIndex(i, targetList[i].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        scrolledUnderElevation: 0.5,
        title: Text(
          "ToDo List",
          style: const TextStyle(
            fontFamily: "Hind",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/Dashboard',
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildSection("Pending Tasks", pendingTodos, false),
                  _buildSection("Completed Tasks", completedTodos, true),
                ],
              ),
            ),
    );
  }

  Widget _buildSection(String title, List<ToDo> todos, bool isCompleted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: "Hind",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              if (!isCompleted)
                IconButton(
                  icon: const Icon(Icons.add, size: 26.0),
                  onPressed: () async {
                    int newIndex =
                        pendingTodos.isEmpty ? 1 : pendingTodos.last.index + 1;

                    await _todoDB.addToDoTask(newIndex);

                    List<ToDo> updatedPending =
                        await _todoDB.fetchPendingToDoTasks();
                    setState(() {
                      pendingTodos = updatedPending;
                    });
                    print(newIndex);
                  },
                ),
            ],
          ),
        ),
        todos.isEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 13, top: 15, bottom: 15),
                child: Center(
                  child: const Text(
                    "No tasks available",
                    style: TextStyle(
                      fontFamily: "Hind",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0x40000000),
                    ),
                  ),
                ),
              )
            : ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                onReorder: (oldIndex, newIndex) async {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final ToDo item = todos.removeAt(oldIndex);
                    todos.insert(newIndex, item);
                  });
                  for (int i = 0; i < todos.length; i++) {
                    todos[i].index = i;
                    await _todoDB.updateToDoIndex(todos[i].index, todos[i].id);
                  }
                },
                itemBuilder: (context, index) {
                  ToDo todo = todos[index];
                  return ListTile(
                    key: ValueKey(todo.id),
                    title: Row(
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                              value: isCompleted,
                              activeColor: Color(0xFF4EABCC),
                              checkColor: Color(0xFFFFFFFF),
                              onChanged: (value) {
                                _updateTodoStatus(index, isCompleted);
                              }),
                        ),
                        Expanded(
                          child: ToDoTextField(
                            text: todo.content.trim(),
                            onChanged: (newText) {
                              _updateTodo(index, newText, isCompleted);
                            },
                            onEmptyDelete: () {
                              _deleteTodo(index, isCompleted);
                            },
                          ),
                        ),
                      ],
                    ),
                    leading: const Icon(Icons.drag_indicator, size: 26.0),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, size: 26.0),
                        onPressed: () {
                          _deleteTodo(index, isCompleted);
                        }),
                  );
                },
              ),
      ],
    );
  }
}
