import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceS extends StatefulWidget {
  const AttendanceS({Key? key}) : super(key: key);

  @override
  State<AttendanceS> createState() => _AttendanceSState();
}

class _AttendanceSState extends State<AttendanceS> {
// final  CalendarController _calendarController = CalendarController();
  DateTime today = DateTime.now();
  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          height: sheight * 0.2,
          width: double.infinity,
          color: Colors.amber,
        ),
      ),
      Positioned(
          top: sheight * 0.16,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: sheight,
            width: double.infinity,
            decoration:const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(30.0), // Set the top-left corner radius
                topRight: Radius.circular(
                    30.0), // Set the top-right corner radius
              ),
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
               children: [
                const TabBar(
                   tabs: [
                     Tab(text: 'Tab 1'),
                     Tab(text: 'Tab 2'),
                  
                   ],
                 ),
                 Expanded(
                   
                   child: TabBarView(
                     children: [
                       // Content for Tab 1
                       SingleChildScrollView(
                         child: Column(children: [
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           TableCalendar(
                             locale: "en_US",
                             rowHeight: 40,
                             headerStyle: HeaderStyle(
                                 formatButtonVisible: false,
                                 titleCentered: true),
                             availableGestures: AvailableGestures.none,
                             selectedDayPredicate: (day) =>
                                 isSameDay(day, today),
                             focusedDay: today,
                             firstDay: DateTime(1948),
                             lastDay: DateTime(2100),
                             onDaySelected: onDaySelected,
                           ),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           Text("data"),
                           
                         ]),
                       ),
                            
                       // Content for Tab 2
                       Center(
                         child: Text('Tab 2 Content'),
                       ),
                      
                     ],
                   ),
                 ),
               ],
                                ),
            ),
          ))
    ])));
  }
}
