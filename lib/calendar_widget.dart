import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  home_widgets createState() => home_widgets();
}

class home_widgets extends State<MyWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData(); // This will load data from widget every time app is opened
  }

  void loadData() async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value!;
    });
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    updateAppWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
