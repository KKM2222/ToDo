import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'login_page.dart';

void main() async {
  await initializeDateFormatting();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Toast-it",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toast-It')),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: CalendarWidget(
          myEvent: myEvent,
          focusedDay: focusedDay, // 전달
          selectedDay: selectedDay, // 전달
          onDayPressed: (DateTime datetime) {
            setState(() {
              selectedDay = datetime; // 선택된 날짜 업데이트
            });
          },
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
}

class CalendarWidget extends StatelessWidget {
  final Map<DateTime, List<MyEvent>> myEvent;
  late final DateTime focusedDay;
  late final DateTime selectedDay;
  final Function(DateTime) onDayPressed;

  CalendarWidget({
    required this.myEvent,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
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
            weekendTextStyle: TextStyle(color: Colors.red), // 주말 텍스트 스타일
            rowDecoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            markersMaxCount: 3, // 각 날짜에 표시될 마커의 최대 수
            markersAutoAligned: true,// 마커가 날짜 아래에 나타나도록 설정
            canMarkersOverflow : false,
            markersOffset : const PositionedOffset(),
            markersAlignment: Alignment.bottomCenter, // 마커의 정렬 위치
            markerDecoration : const BoxDecoration(
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
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                color: Colors.grey.shade300,
                child: ListTile(
                  title: Text(event.content, style: TextStyle(color: Colors.black)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventsMarker(List<MyEvent> events) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Text(
        events.length.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class MyEvent {
  DateTime date;
  String content;

  MyEvent(this.date, this.content);
}
