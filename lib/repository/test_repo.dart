import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetRepository {
  static Future<Response> atten() async {
    final response = await http.post(
        Uri.parse("https://erp.classonapp.com/apis/v1/month_attendance"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "app_type": "1",
          "device_type": "1",
          "access_token":
              "68759d747273a15ffc8e4ac2510676c4_classonapp_442adc02da4ccc4e74894b82fddc1666",
          "school_id": "1",
          "student_id": "86",
          "date": "2024-01-26"
        }));

    print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  }
}
