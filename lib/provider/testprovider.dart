import 'package:flutter/material.dart';

class OTPProvider with ChangeNotifier {
  String _otpStatus = '';

  String get otpStatus => _otpStatus;

  void setOTPStatus(String status) {
    _otpStatus = status;
    notifyListeners();
  }
}
