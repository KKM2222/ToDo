import 'package:flutter/material.dart';
import 'diary_page.dart';
import 'mandalart_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> todos = [];
  int currentPageIndex = 1; // 초기 페이지는 To-Do List
  PageController pageController = PageController(initialPage: 1);
  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('뚜두뚜두'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (currentPageIndex > 0) {
                    setState(() {
                      currentPageIndex--;
                    });
                    pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              Text(
                currentPageIndex == 0
                    ? "Diary"
                    : (currentPageIndex == 1 ? "To-Do List" : "Mandalart"),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (currentPageIndex < 2) {
                    setState(() {
                      currentPageIndex++;
                    });
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              children: [
                DiaryPage(),
                TodoPage(todos: todos, onToggle: toggleTodo, onDelete: deleteTodo),
                MandalartPage(),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('메뉴 항목 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('메뉴 항목 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: currentPageIndex == 1
          ? FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: Icon(Icons.add),
      )
          : null,
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('할 일 추가'),
          content: TextField(
            controller: todoController,
            decoration: InputDecoration(labelText: '할 일'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                addTodo(todoController.text);
                Navigator.pop(context);
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  void addTodo(String todo) {
    setState(() {
      todos.add(TodoItem(title: todo));
      _sortTodos();
      todoController.clear();
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
      _sortTodos();
    });
  }

  void _sortTodos() {
    todos.sort((a, b) {
      if (a.isDone && !b.isDone) {
        return 1;
      } else if (!a.isDone && b.isDone) {
        return -1;
      } else {
        return 0;
      }
    });
  }
}

class TodoPage extends StatelessWidget {
  final List<TodoItem> todos;
  final Function(int) onToggle;
  final Function(int) onDelete;

  TodoPage({required this.todos, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
            value: todos[index].isDone,
            onChanged: (value) {
              onToggle(index);
            },
          ),
          title: Text('${index + 1}. ${todos[index].title}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(index);
            },
          ),
        );
      },
    );
  }
}

class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}
