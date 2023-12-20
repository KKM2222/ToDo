import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  await initializeDateFormatting();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Toast-it",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<DateTime, List<MyEvent>> myEvent = {};
  DateTime focusedDay = DateTime.now(); // 초기화
  DateTime selectedDay = DateTime.now(); // 초기화

  void _selectDay(DateTime day) {
    setState(() {
      selectedDay = day;
      focusedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toast-It')),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: CalendarWidget(
          myEvent: myEvent,
          focusedDay: focusedDay,
          selectedDay: selectedDay,
          onDayPressed: _selectDay, // _selectDay 함수로 변경
          deleteEvent: _deleteEvent,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController contentController = TextEditingController();
              return AlertDialog(
                title: const Text("일정 추가"),
                content: Container(
                  height: 100,
                  child: Column(
                    children: [
                      Text(
                        DateFormat("yyyy-MM-dd").format(selectedDay),
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: contentController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(labelText: '일정'),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      String eventContent = contentController.value.text;
                      setState(() {
                        if (myEvent[selectedDay] == null) {
                          myEvent[selectedDay] = [MyEvent(selectedDay, eventContent)];
                        } else {
                          myEvent[selectedDay]!.add(MyEvent(selectedDay, eventContent));
                        }
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("등록"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("취소"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // _selectDay 함수를 사용하여 selectedDay 업데이트
  void _deleteEvent(MyEvent event) {
    setState(() {
      myEvent[event.date]?.remove(event);
    });
  }
}

class CalendarWidget extends StatelessWidget {
  final Map<DateTime, List<MyEvent>> myEvent;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Function(DateTime) onDayPressed;
  final Function(MyEvent) deleteEvent;

  CalendarWidget({
    required this.myEvent,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDayPressed,
    required this.deleteEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, dynamic event){
              if (event.isNotEmpty) {
                return Container(
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      shape: BoxShape.circle),
                );
              }
            }
          ),
          locale: "ko_KR",
          calendarFormat: CalendarFormat.month,
          focusedDay: focusedDay,
          firstDay: DateTime(2000),
          lastDay: DateTime(2050),
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            onDayPressed(selectedDay);
            selectedDay = selectedDay;
          },
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextFormatter: (date, locale) =>
                DateFormat.yMMMMd(locale).format(date),
            formatButtonVisible: false,
            titleTextStyle: const TextStyle(
              fontSize: 20.0, color: Colors.blue,
            ),
            headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
            leftChevronIcon: const Icon(
              Icons.arrow_left,
              size: 40.0,
            ),
            rightChevronIcon: const Icon(
              Icons.arrow_right,
              size: 40.0,
            ),
            formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
            formatButtonDecoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          calendarStyle: CalendarStyle(
            weekendTextStyle: TextStyle(color: Colors.red),
            rowDecoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            markersMaxCount: 3,
            markersAutoAligned: true,
            canMarkersOverflow: false,
            markersOffset: const PositionedOffset(),
            markersAlignment: Alignment.bottomCenter,
            markerDecoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: myEvent[selectedDay] != null ? myEvent[selectedDay]!.length : 0,
            itemBuilder: (BuildContext context, int index) {
              MyEvent event = myEvent[selectedDay]![index];
              return Dismissible(
                key: Key(event.content),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  deleteEvent(event);
                },
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.circle, color: Colors.red,),
                  title: Container(
                    child: Text(
                        event.content,
                        style: TextStyle(color: Colors.black, fontSize: 40)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MyEvent {
  DateTime date;
  String content;

  MyEvent(this.date, this.content);
}
