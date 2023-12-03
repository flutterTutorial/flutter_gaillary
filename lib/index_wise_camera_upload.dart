// import 'package:image_picker/image_picker.dart';

// // ... other imports

// class _CardWidgetState extends State<CardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             _captureImage(context);
//           },
//           child: const Text('Capture Image from Camera'),
//         ),
//         Container(
//           height: 300.0,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: widget.card.images.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 height: 100.0,
//                 child: Image.file(
//                   File(widget.card.images[index]),
//                   height: 100.0,
//                   width: 100.0,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _captureImage(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       // Update the 'images' list with the captured image
//       setState(() {
//         widget.card.images.add(pickedFile.path);
//       });
//     }
//   }

//   // ... rest of the code
// }
