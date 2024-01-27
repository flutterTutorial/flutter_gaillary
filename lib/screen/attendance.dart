import 'package:flutter/material.dart';
import 'package:flutter_gallery/model/attendance.dart';
import 'package:flutter_gallery/provider/testprovider.dart';
import 'package:flutter_gallery/screen/story.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DemoTest extends StatefulWidget {
  const DemoTest({Key? key}) : super(key: key);

  @override
  State<DemoTest> createState() => _DemoTestState();
}

class _DemoTestState extends State<DemoTest> {
  DateTime today = DateTime.now();
  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

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
    Provider.of<OTPProvider>(context,listen: false).getAtten();
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
                      MaterialPageRoute(builder: (context) => StoryPage()));
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
                        locale: "en_US",
                        rowHeight: 50,
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        availableGestures: AvailableGestures.none,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        focusedDay: today,
                        firstDay: DateTime(1948),
                        lastDay: DateTime(2100),
                        onDaySelected: onDaySelected,
                        calendarBuilders: CalendarBuilders(
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
                                      color: _getStatusColor(
                                          d.attendanceStatus!),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(
                                            color: Colors.white),
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
