import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gallery/model/attendance.dart';
import 'package:flutter_gallery/repository/test_repo.dart';

class OTPProvider with ChangeNotifier {
  String _otpStatus = '';
  String get otpStatus => _otpStatus;
bool isLoading = false;
  AttendanceModel? attendanceModel;

  void setOTPStatus(String status) {
    _otpStatus = status;
    notifyListeners();
  }

  void getAtten() {
    isLoading = true;
    GetRepository.atten().then((value) {
      Map<String, dynamic> responseData = jsonDecode(value.body);
      if (responseData['success'] == 1) {
        attendanceModel = AttendanceModel.fromJson(responseData);
      }
      isLoading = false;
      notifyListeners();
    });
  }
}
