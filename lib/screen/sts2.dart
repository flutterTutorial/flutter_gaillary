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
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar with Scrollable Content'),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Content for Tab 1
                  SingleChildScrollView(
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                          rowHeight: 50,
                          headerStyle: HeaderStyle(
                              formatButtonVisible: false, titleCentered: true),
                          availableGestures: AvailableGestures.none,
                          selectedDayPredicate: (day) => isSameDay(day, today),
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
                        Text("data"),
                        Text("data"),
                      ]),
                    ),
                  ),

                  // Content for Tab 2
                  Center(
                    child: Text('Tab 2 Content'),
                  ),

                  // Content for Tab 3
                  Center(
                    child: Text('Tab 3 Content'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
