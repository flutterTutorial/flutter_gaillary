import 'package:flutter/material.dart';
import 'package:flutter_gallery/model/attendance.dart';
import 'package:flutter_gallery/provider/testprovider.dart';
import 'package:flutter_gallery/screen/customstory.dart';
import 'package:flutter_gallery/screen/story.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DemoTest extends StatefulWidget {
  const DemoTest({Key? key}) : super(key: key);

  @override
  State<DemoTest> createState() => _DemoTestState();
}

class _DemoTestState extends State<DemoTest> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Map<String, dynamic>> attendant = [
    {"id": 27806, "date": "2024-01-01", "remarks": "", "attendance_status": 4},
    {"id": 27838, "date": "2024-01-02", "remarks": "", "attendance_status": 1},
    {"id": 27870, "date": "2024-01-03", "remarks": "", "attendance_status": 3},
    {
      "id": 27902,
      "date": "2024-01-04",
      "remarks": "ABC",
      "attendance_status": 4
    },
    {"id": 27934, "date": "2024-01-05", "remarks": "", "attendance_status": 4},
    {"id": 27966, "date": "2024-01-06", "remarks": "", "attendance_status": 3},
    {"id": 28010, "date": "2024-01-09", "remarks": "", "attendance_status": 1},
    {"id": 28042, "date": "2024-01-08", "remarks": "", "attendance_status": 1},
    {"id": 28103, "date": "2024-01-10", "remarks": "", "attendance_status": 4},
    {"id": 28177, "date": "2024-01-15", "remarks": "", "attendance_status": 1},
    {"id": 28209, "date": "2024-01-12", "remarks": "", "attendance_status": 1},
    {"id": 28241, "date": "2024-01-11", "remarks": "", "attendance_status": 1},
    {"id": 28273, "date": "2024-01-16", "remarks": "", "attendance_status": 1},
    {"id": 28305, "date": "2024-01-17", "remarks": "", "attendance_status": 1},
    {"id": 28337, "date": "2024-01-18", "remarks": "", "attendance_status": 2},
    {"id": 28369, "date": "2024-01-19", "remarks": "", "attendance_status": 4},
    {"id": 28401, "date": "2024-01-20", "remarks": "", "attendance_status": 3},
    {"id": 28433, "date": "2024-01-23", "remarks": "", "attendance_status": 4},
    {"id": 28465, "date": "2024-01-22", "remarks": "", "attendance_status": 4},
    {"id": 28497, "date": "2024-01-24", "remarks": "", "attendance_status": 3},
    {"id": 28529, "date": "2024-01-25", "remarks": "", "attendance_status": 3}
  ];

  @override
  void initState() {
    Provider.of<OTPProvider>(context, listen: false).getAtten("2024-01-01");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CustomStory()));
                },
                icon: Icon(Icons.abc))
          ],
        ),
        body: Column(
          children: [
            Consumer<OTPProvider>(
              builder: (context, attenPro, child) {
                return attenPro.isLoading == true
                    ? const CircularProgressIndicator()
                    : TableCalendar(
                        firstDay: DateTime(1948),
                        lastDay: DateTime(2100),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        // selectedDayPredicate: (day) {
                        //   // Use `selectedDayPredicate` to determine which day is currently selected.
                        //   // If this returns true, then `day` will be marked as selected.

                        //   // Using `isSameDay` is recommended to disregard
                        //   // the time-part of compared DateTime objects.
                        //   return isSameDay(_selectedDay, day);
                        // },
                         headerStyle: const HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            // Call `setState()` when updating the selected day
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                        },
                        // onFormatChanged: (format) {
                        //   if (_calendarFormat != format) {
                        //     // Call `setState()` when updating calendar format
                        //     setState(() {
                        //       _calendarFormat = format;
                        //     });
                        //   }
                        // },
                        // calendarStyle:  CalendarStyle(
                         
                        //   todayDecoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: _getStatusColor(2)                  
                        //        ),
                        // //        todayTextStyle: TextStyle(
                        // //       color:  Colors.black,
                        // // ),
                        // ),
                        onPageChanged: (focusedDay) {
                          // No need to call `setState()` here
                          _focusedDay = focusedDay;
                          attenPro.getAtten("2024-02-02");

                        },

                         calendarBuilders: CalendarBuilders(
                          todayBuilder: (context, day, focusedDay) {
                             for (Data dd in attenPro.attendanceModel!.data!) {
                              DateTime date = DateTime.parse(dd.date!);
                              if (isSameDay(day, date)) {
                                return Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(dd.attendanceStatus!),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${day.day}',
                                    ),
                                  ),
                                );
                              }
                            }
                            return null;
                          },
                          defaultBuilder: (context, day, focusedDay) {
                          
                            // Check if attendanceModel and data are not null
                            if (attenPro.attendanceModel != null &&
                                attenPro.attendanceModel!.data != null) {
                              for (Data d in attenPro.attendanceModel!.data!) {
                                DateTime date = DateTime.parse(d.date!);
                                if (isSameDay(day, date)) {
                                  return Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color:
                                          _getStatusColor(d.attendanceStatus!),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                            return null;
                          },
                        ),
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<OTPProvider>(
                builder: (context, countPro, child) {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(countPro.attenCount.isNotEmpty
                              ? countPro.attenCount[1].toString()
                              : "0")),
                      Expanded(
                          child: Text(countPro.attenCount[2] != null
                              ? countPro.attenCount[2].toString()
                              : "0")),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(dynamic number) {
    switch (number) {
      case 1:
        return Colors.green; // Present (Green)
      case 2:
        return Colors.red; // Absent (Red)
      case 3:
        return Colors.orange; // Leave (Orange)
      case 4:
        return Colors.purple; // Halfday (Purple)
      case 5:
        return Colors.blue; // Holiday (Blue)
      default:
        return Colors.grey;
    }
  }
}
