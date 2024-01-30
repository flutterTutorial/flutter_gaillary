import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gallery/custom/functions.dart';
import 'package:flutter_gallery/model/attendance.dart';
import 'package:flutter_gallery/repository/test_repo.dart';

class OTPProvider with ChangeNotifier {
  String _otpStatus = '';
  String get otpStatus => _otpStatus;
  bool isLoading = false;
  AttendanceModel? attendanceModel;

  Map<int, int> _attenCount = {};
  Map<int, int> get attenCount => _attenCount;

  void setOTPStatus(String status) {
    _otpStatus = status;
    notifyListeners();
  }

  void getAtten(String date) {
    isLoading = true;
    GetRepository.atten(date).then((value) {
      Map<String, dynamic> responseData = jsonDecode(value.body);
      if (responseData['success'] == 1) {
        attendanceModel = AttendanceModel.fromJson(responseData);
        _attenCount = Functions.getCountAtten(attendanceModel!.data);
      }
      print(_attenCount);
      isLoading = false;
      notifyListeners();
    });
  }

   void getAttenCount(String date) {
    isLoading = true;
    GetRepository.attenCount(date).then((value) {
      Map<String, dynamic> responseData = jsonDecode(value.body);
      if (responseData['success'] == 1) {
        attendanceModel = AttendanceModel.fromJson(responseData);
      }
      isLoading = false;
      notifyListeners();
    });
  }
}
