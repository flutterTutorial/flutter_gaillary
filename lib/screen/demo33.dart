import 'package:flutter/material.dart';
import 'package:flutter_gallery/provider/testprovider.dart';
import 'package:flutter_gallery/utils/mycolors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class YourOtherPage extends StatefulWidget {
  @override
  State<YourOtherPage> createState() => _YourOtherPageState();
}

class _YourOtherPageState extends State<YourOtherPage> {
  TextEditingController _mobileController = new TextEditingController();
  bool _suffixIcon = false, _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: _mobileController,
          cursorColor: MyColors.toolDark,
          style: GoogleFonts.roboto(
            color: MyColors.textcolor,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
          onChanged: (value) {
            setState(() {
              if (value.length == 10) {
                _suffixIcon = true;
              } else {
                _suffixIcon = false;
              }
            });
          },
          maxLength: 10,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            fillColor: MyColors.textfiledbg,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            icon: Icon(
              Icons.smartphone_rounded,
              color: MyColors.textcolor,
            ),
            suffixIcon: _suffixIcon
                ? Icon(
                    Icons.check_circle_rounded,
                    color: MyColors.textcolor,
                  )
                : Icon(
                    Icons.check_circle_outline_rounded,
                    color: MyColors.textcolor,
                  ),
          ),
        ),
            Consumer<OTPProvider>(
              builder: (context, otpProvider, child) {
                return Text('OTP Status: ${otpProvider.otpStatus}');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Set the OTP status in the provider
                Provider.of<OTPProvider>(context, listen: false)
                    .setOTPStatus('New Status');
              },
              child: Text('Update  Status'),
            ),
          ],
        ),
      ),
    );
  }
}
