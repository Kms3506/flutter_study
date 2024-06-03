import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'memo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        body: TodoScreen(dbHelper: dbHelper),
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  final DatabaseHelper dbHelper;

  TodoScreen({required this.dbHelper});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late Future<List<Todo>> todos;
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todos = widget.dbHelper.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: contentController,
            decoration: InputDecoration(hintText: 'Enter your todo'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String content = contentController.text;
              if (content.isNotEmpty) {
                await widget.dbHelper.insertTodo(Todo(content: content));
                contentController.clear();
                setState(() {
                  todos = widget.dbHelper.getTodos();
                });
              }
            },
            child: Text('Add Todo'),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: todos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Todo> todoList = snapshot.data as List<Todo>;
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(todoList[index].content),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editTodo(context, todoList[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteTodo(context, todoList[index]);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _editTodo(BuildContext context, Todo todo) {
    contentController.text = todo.content;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextField(
            controller: contentController,
            decoration: InputDecoration(hintText: 'Enter your edited todo'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String content = contentController.text;
                if (content.isNotEmpty) {
                  todo.content = content;
                  await widget.dbHelper.updateTodo(todo);
                  Navigator.pop(context);
                  setState(() {
                    todos = widget.dbHelper.getTodos();
                  });
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTodo(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: Text('Are you sure you want to delete this todo?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.dbHelper.deleteTodo(todo.id!);
                Navigator.pop(context);
                setState(() {
                  todos = widget.dbHelper.getTodos();
                });
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
