// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:flutter_calendar_carousel/classes/event.dart';
//
// class CalendarPage extends StatefulWidget {
//   const CalendarPage({Key? key});
//
//   @override
//   State<CalendarPage> createState() => _CalendarPageState();
// }
//
// class Event {
//   String eventName;
//
//   Event(this.eventName);
//
//   @override
//   String toString() {
//     return eventName;
//   }
// }
// class MyEvent{
//   String date;
//   String content;
//
//   MyEvent(this.date, this.content);
// }
//
//
// class _CalendarPageState extends State<CalendarPage> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   Map<DateTime, List<Event>> events = {};
//   TextEditingController _eventController = TextEditingController();
//   late final ValueNotifier<List<Event>> _selectedEvents;
//   EventList<Event> markedDateMap = EventList(events: {});
//   List<MyEvent> myevent = List.empty(growable: true);
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   }
//
//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }
//
//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//         _selectedEvents.value = _getEventsForDay(selectedDay);
//       });
//     }
//   }
//
//   List<Event> _getEventsForDay(DateTime day) {
//     return events[day] ?? [];
//   }
//
//   void _deleteEvent(Event event) {
//     setState(() {
//       events[_selectedDay!]!.remove(event);
//       _selectedEvents.value = _getEventsForDay(_selectedDay!);
//     });
//   }
//
//   void _editEvent(Event event) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         TextEditingController _editController = TextEditingController(text: event.eventName);
//
//         return AlertDialog(
//           scrollable: true,
//           title: Text("할 일 수정"),
//           content: Padding(
//             padding: EdgeInsets.all(8),
//             child: TextField(
//               controller: _editController,
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 events[_selectedDay!]!.remove(event);
//                 events[_selectedDay!]!.add(Event(_editController.text));
//                 Navigator.of(context).pop();
//                 _selectedEvents.value = _getEventsForDay(_selectedDay!);
//                 _editController.clear();
//               },
//               child: Text("수정"),
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     markedDateMap = EventList(events: {});
//     for(int i = 0; i<myevent.length; i++){
//       MyEvent event = myevent[i];
//       List dateDelim = event.date.split('-');
//       DateTime eventDate = DateTime(
//         int.parse(dateDelim[0]),
//         int.parse(dateDelim[1]),
//         int.parse(dateDelim[2]),
//       );
//       markedDateMap.add(
//         eventDate,
//         Event(
//           date: eventDate,
//         icon:Container(decoration: BoxDecoration(
//           color: Colors.blue
//         ),
//         )
//         )
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("TOAST-IT"),
//         centerTitle: true,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               _eventController.clear();
//               return AlertDialog(
//                 scrollable: true,
//                 title: Text("할 일 적기"),
//                 content: Padding(
//                   padding: EdgeInsets.all(8),
//                   child: TextField(
//                     controller: _eventController,
//                   ),
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_eventController.text.isNotEmpty) {
//                         // 기존 할 일 목록이 있는 경우에만 추가
//                         if (events.containsKey(_selectedDay)) {
//                           events[_selectedDay!]!.add(Event(_eventController.text));
//                         } else {
//                           events[_selectedDay!] = [Event(_eventController.text)];
//                         }
//                         Navigator.of(context).pop();
//                         _selectedEvents.value = _getEventsForDay(_selectedDay!);
//                         _eventController.clear(); // 새로운 할 일 추가 후 텍스트 필드 초기화
//                       }
//                     },
//                     child: Text("추가"),
//                   )
//                 ],
//               );
//             },
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//       body: Column(
//         children: [
//           TableCalendar(
//             locale: "ko_KR",
//             headerVisible: true,
//             focusedDay: _focusedDay,
//             firstDay: DateTime.utc(2010, 3, 14),
//             lastDay: DateTime.utc(2030, 3, 14),
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             calendarFormat: _calendarFormat,
//             startingDayOfWeek: StartingDayOfWeek.sunday,
//             onDaySelected: _onDaySelected,
//             eventLoader: _getEventsForDay,
//             calendarStyle: CalendarStyle(
//               outsideDaysVisible: false,
//             ),
//             onFormatChanged: (format) {
//               if (_calendarFormat != format) {
//                 setState(() {
//                   _calendarFormat = format;
//                 });
//               }
//             },
//             onPageChanged: (focusedDay) {
//               _focusedDay = focusedDay;
//             },
//           ),
//           SizedBox(height: 8.0),
//           Expanded(
//             child: ValueListenableBuilder<List<Event>>(
//               valueListenable: _selectedEvents,
//               builder: (context, value, _) {
//                 return ListView.builder(
//                   itemCount: value.length,
//                   reverse: false, // 가장 최근에 추가한 항목이 맨 위에 오도록 역순으로 표시
//                   itemBuilder: (context, index) {
//                     return Dismissible(
//                       key: UniqueKey(),
//                       direction: DismissDirection.horizontal,
//                       onDismissed: (direction) {
//                         if (direction == DismissDirection.endToStart) {
//                           _deleteEvent(value[index]);
//                         }
//                       },
//                       background: Container(
//                         color: Colors.red,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 16.0),
//                               child: Icon(
//                                 Icons.delete,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Spacer(),
//                           ],
//                         ),
//                       ),
//                       secondaryBackground: Container(
//                         color: Colors.red,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Spacer(),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 16.0),
//                               child: Icon(
//                                 Icons.delete,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                         decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           onTap: () => _editEvent(value[index]), // 수정 기능 호출
//                           title: Text("${value[index]}"),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   String _formattedDate(DateTime date) {
//     return DateFormat('yyyy년 MM월 dd일', 'ko_KR').format(date);
//   }
// }