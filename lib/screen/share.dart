import 'dart:io';
import 'package:file_selector/file_selector.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class ShareTest extends StatefulWidget {
  const ShareTest({Key? key}) : super(key: key);

  @override
  ShareTestState createState() => ShareTestState();
}

class ShareTestState extends State<ShareTest> {
  String text = '';
  String subject = '';
  String uri = 'https://www.kasandbox.org/programming-images/avatars/spunky-sam-green.png';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Plus Plugin Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Share Plus Plugin Demo'),
          elevation: 4,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share text',
                  hintText: 'Enter some text and/or link to share',
                ),
                maxLines: null,
                onChanged: (String value) => setState(() {
                  text = value;
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share subject',
                  hintText: 'Enter subject to share (optional)',
                ),
                maxLines: null,
                onChanged: (String value) => setState(() {
                  subject = value;
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share uri',
                  hintText: 'Enter the uri you want to share',
                ),
                maxLines: null,
                onChanged: (String value) {
                  setState(() => uri = value);
                },
              ),
              const SizedBox(height: 16),
              // ImagePreviews(imagePaths, onDelete: _onDeleteImage),
              ElevatedButton.icon(
                label: const Text('Add image'),
                onPressed: () async {
                  // Using `package:image_picker` to get image from gallery.
                  if (!kIsWeb &&
                      (Platform.isMacOS ||
                          Platform.isLinux ||
                          Platform.isWindows)) {
                    // Using `package:file_selector` on windows, macos & Linux, since `package:image_picker` is not supported.
                    const XTypeGroup typeGroup = XTypeGroup(
                      label: 'images',
                      extensions: <String>['jpg', 'jpeg', 'png', 'gif'],
                    );
                    final file = await openFile(
                        acceptedTypeGroups: <XTypeGroup>[typeGroup]);
                    if (file != null) {
                      setState(() {
                        imagePaths.add(file.path);
                        imageNames.add(file.name);
                      });
                    }
                  } else {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        imagePaths.add(pickedFile.path);
                        imageNames.add(pickedFile.name);
                      });
                    }
                  }
                },
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: 32),
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed:  () => _onShare("https://www.kasandbox.org/programming-images/avatars/spunky-sam-green.png","context"),
                    child: const Text('Share'),
                  );
                },
              ),
              // const SizedBox(height: 16),
              // Builder(
              //   builder: (BuildContext context) {
              //     return ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         foregroundColor: Theme.of(context).colorScheme.onPrimary,
              //         backgroundColor: Theme.of(context).colorScheme.primary,
              //       ),
              //       onPressed: text.isEmpty && imagePaths.isEmpty
              //           ? null
              //           : () => _onShareWithResult(context),
              //       child: const Text('Share With Result'),
              //     );
              //   },
              // ),
              // const SizedBox(height: 16),
              // Builder(
              //   builder: (BuildContext context) {
              //     return ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         foregroundColor: Theme.of(context).colorScheme.onPrimary,
              //         backgroundColor: Theme.of(context).colorScheme.primary,
              //       ),
              //       onPressed: () {
              //         _onShareXFileFromAssets(context);
              //       },
              //       child: const Text('Share XFile from Assets'),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
      imageNames.removeAt(position);
    });
  }

  Future<void> _onShare(String imageUrl, String text) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    final Directory directory = await getTemporaryDirectory();
    final File file = await File('${directory.path}/Image.png')
        .writeAsBytes(response.bodyBytes);
    await Share.shareXFiles(
      [
        XFile(file.path),
      ],
      text: text,
    );
  } 

  // void _onShare(BuildContext context) async {
    
  //   final box = context.findRenderObject() as RenderBox?;

  //   if (uri.isNotEmpty) {
  //     await Share.shareUri(Uri.parse(uri));
  //   } else if (imagePaths.isNotEmpty) {
  //     final files = <XFile>[];
  //     for (var i = 0; i < imagePaths.length; i++) {
  //       files.add(XFile(imagePaths[i], name: imageNames[i]));
  //     }
  //     await Share.shareXFiles(files,
  //         text: text,
  //         subject: subject,
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   } else {
  //     await Share.share(text,
  //         subject: subject,
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   }
  // }

  // void _onShareWithResult(BuildContext context) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //   ShareResult shareResult;
  //   if (imagePaths.isNotEmpty) {
  //     final files = <XFile>[];
  //     for (var i = 0; i < imagePaths.length; i++) {
  //       files.add(XFile(imagePaths[i], name: imageNames[i]));
  //     }
  //     shareResult = await Share.shareXFiles(files,
  //         text: text,
  //         subject: subject,
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   } else {
  //     shareResult = await Share.shareWithResult(text,
  //         subject: subject,
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   }
  //   scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  // }

  // void _onShareXFileFromAssets(BuildContext context) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //   final data = await rootBundle.load('assets/flutter_logo.png');
  //   final buffer = data.buffer;
  //   final shareResult = await Share.shareXFiles(
  //     [
  //       XFile.fromData(
  //         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
  //         name: 'flutter_logo.png',
  //         mimeType: 'image/png',
  //       ),
  //     ],
  //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  //   );

  //   scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  // }

  // SnackBar getResultSnackBar(ShareResult result) {
  //   return SnackBar(
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("Share result: ${result.status}"),
  //         if (result.status == ShareResultStatus.success)
  //           Text("Shared to: ${result.raw}")
  //       ],
  //     ),
  //   );
  // }

}
