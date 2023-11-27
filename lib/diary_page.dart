import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageSlider(),
    );
  }
}

class PageSlider extends StatefulWidget {
  @override
  _PageSliderState createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  late PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('토독'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: [
          Main(),
          DiaryPage(onNavigate: nextPage),
          TodoList(onNavigate: nextPage),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: nextPage,
            child: Icon(Icons.arrow_forward),
            backgroundColor: Colors.pinkAccent,
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: previousPage,
            child: Icon(Icons.arrow_back),
            backgroundColor: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }

  void nextPage() {
    currentPageIndex = (currentPageIndex + 1) % 3;
    _pageController.animateToPage(
      currentPageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    currentPageIndex = (currentPageIndex - 1 + 3) % 3;
    _pageController.animateToPage(
      currentPageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Main Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class DiaryPage extends StatelessWidget {
  final VoidCallback onNavigate;

  const DiaryPage({Key? key, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Diary Page',
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: onNavigate,
            child: Text('Next Page'),
          ),
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final VoidCallback onNavigate;

  const TodoList({Key? key, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'To-Do List',
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: onNavigate,
            child: Text('Next Page'),
          ),
        ],
      ),
    );
  }
}
