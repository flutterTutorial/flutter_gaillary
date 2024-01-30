import 'package:flutter_gallery/model/attendance.dart';

class Functions{
  static getCountAtten(List<Data>? data){
   Map<int, int> statusCount = {};
    for (var entry in data!) {
      int status = entry.attendanceStatus!;
      statusCount[status] = (statusCount[status] ?? 0) + 1;
    }
    return statusCount;
  }
}