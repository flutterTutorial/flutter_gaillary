class AttendanceModel {
  int? success;
  String? message;
  List<Data>? data;

  AttendanceModel({this.success, this.message, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? date;
  String? remarks;
  int? attendanceStatus;

  Data({this.id, this.date, this.remarks, this.attendanceStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    remarks = json['remarks'];
    attendanceStatus = json['attendance_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['remarks'] = this.remarks;
    data['attendance_status'] = this.attendanceStatus;
    return data;
  }
}
