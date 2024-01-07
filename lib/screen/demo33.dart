// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gallery/provider/testprovider.dart';
// import 'package:flutter_gallery/utils/mycolors.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class YourOtherPage extends StatefulWidget {
//   @override
//   State<YourOtherPage> createState() => _YourOtherPageState();
// }

// class _YourOtherPageState extends State<YourOtherPage> {
//   TextEditingController _mobileController = new TextEditingController();
//   bool _suffixIcon = false, _isLoading = false;

//   void getInitialMessage() async {
//     RemoteMessage? message =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (message != null) {
//       print("1A");

//       // if (message.data["page"] == "email") {
//       //   Navigator.push(
//       //       context, CupertinoPageRoute(builder: (context) => SignUpScreen()));
//       // } else if (message.data["page"] == "phone") {
//       //   Navigator.push(context,
//       //       CupertinoPageRoute(builder: (context) => SignInWithPhone()));
//       // } else {
//       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text("Invalid Page!"),
//       //     duration: Duration(seconds: 5),
//       //     backgroundColor: Colors.red,
//       //   ));
//       // }
//     }
//   }
//    @override
//   void initState() {
//     super.initState();

//     getInitialMessage();

//     FirebaseMessaging.onMessage.listen((message) {
      
//       print("1AA");
//       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //   content: Text(message.data["myname"].toString()),
//       //   duration: Duration(seconds: 10),
//       //   backgroundColor: Colors.green,
//       // ));
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print("1AAA");
//       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //   content: Text("App was opened by a notification"),
//       //   duration: Duration(seconds: 10),
//       //   backgroundColor: Colors.green,
//       // ));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Other Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//           textAlignVertical: TextAlignVertical.center,
//           controller: _mobileController,
//           cursorColor: MyColors.toolDark,
//           style: GoogleFonts.roboto(
//             color: MyColors.textcolor,
//             fontWeight: FontWeight.w600,
//             letterSpacing: screenWidth*0.05,
//             fontSize: 16.0,
//           ),
          
//           onChanged: (value) {
//             setState(() {
//               if (value.length == 10) {
//                 _suffixIcon = true;
//               } else {
//                 _suffixIcon = false;
//               }
//             });
//           },
//           maxLength: 10,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             counterText: '',
//             fillColor: MyColors.textfiledbg,
//             // border: InputBorder.none,
//             // errorBorder: InputBorder.none,
//             // enabledBorder: InputBorder.none,
//             // disabledBorder: InputBorder.none,
//             // focusedBorder: InputBorder.none,
//             // focusedErrorBorder: InputBorder.none,
//             icon: Icon(
//               Icons.smartphone_rounded,
//               color: MyColors.textcolor,
//             ),
//             suffixIcon: _suffixIcon
//                 ? Icon(
//                     Icons.check_circle_rounded,
//                     color: MyColors.textcolor,
//                   )
//                 : Icon(
//                     Icons.check_circle_outline_rounded,
//                     color: MyColors.textcolor,
//                   ),
//           ),
//         ),
//             Consumer<OTPProvider>(
//               builder: (context, otpProvider, child) {
//                 return Text('OTP Status: ${otpProvider.otpStatus}');
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Set the OTP status in the provider
//                 Provider.of<OTPProvider>(context, listen: false)
//                     .setOTPStatus('New Status');
//               },
//               child: Text('Update  Status'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
