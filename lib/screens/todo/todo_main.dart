import 'package:chronicles/services/todo_services.dart';
import 'package:chronicles/utilities/components/buttons/galactic_ocean_button.dart';
import 'package:chronicles/screens/todo/completed_todo.dart';
import 'package:chronicles/utilities/components/todo/todo.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/utilities/components/textfields/todo_textfield.dart';

final kTextStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0xFFFFFFFF),
);

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final ToDoDatabaseService _todoDB = ToDoDatabaseService.instance;
  List<ToDo> todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      todos = await _todoDB.fetchPendingToDoTasks();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateTodo(int index, String newText) async {
    await _todoDB.updateToDoTask(todos[index].index, newText);
    setState(() {
      todos[index].content = newText;
    });
  }

  void _updateTodoStatus(int index, int status) async {
    await _todoDB.updateTodoStatus(todos[index].index, status);
    setState(() {
      todos[index].status = status;
    });
  }

  void _deleteTodo(int index) async {
    await _todoDB.deleteToDoTask(todos[index].index);
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: screenHeight * 0.6,
                width: double.infinity,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : todos.isEmpty
                        ? const Center(child: Text('Nothing ToDo'))
                        : ReorderableListView.builder(
                            itemCount: todos.length,
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final item = todos.removeAt(oldIndex);
                                todos.insert(newIndex, item);
                              });
                            },
                            itemBuilder: (context, index) {
                              ToDo todo = todos[index];
                              return ListTile(
                                key: ValueKey(todo.index),
                                title: Row(
                                  children: [
                                    Checkbox(
                                      value: todo.status == 1,
                                      onChanged: (value) {
                                        setState(() {
                                          todo.status = value! ? 1 : 0;
                                          _updateTodoStatus(index, todo.status);
                                          _loadTodos();
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: ToDoTextField(
                                        text: todo.content,
                                        onChanged: (newText) {
                                          _updateTodo(index, newText);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                leading: const Icon(Icons.drag_indicator),
                                trailing: IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  onPressed: () => _deleteTodo(index),
                                ),
                              );
                            },
                          ),
              ),
            ),
            Column(
              children: [
                GalacticOceanButton(
                  horizontalMargin: 70.0,
                  onPress: () {
                    setState(() {
                      int millisecondsSinceEpoch =
                          DateTime.now().millisecondsSinceEpoch;
                      _todoDB.addToDoTask(millisecondsSinceEpoch);
                      _loadTodos();
                    });
                  },
                  buttonLabel: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Add Instant ToDo',
                        style: kTextStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GalacticOceanButton(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompletedTodo(),
                      ),
                    );
                  },
                  buttonLabel: Text(
                    'Completed ToDo',
                    style: kTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
