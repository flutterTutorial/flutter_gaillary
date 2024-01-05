import 'package:flutter/material.dart';
import 'package:flutter_gallery/provider/testprovider.dart';
import 'package:provider/provider.dart';

class YourOtherPage extends StatelessWidget {
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
