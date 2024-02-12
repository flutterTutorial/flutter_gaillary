import 'package:flutter/material.dart';
import 'package:flutter_gallery/screen/download_logic.dart';


class DownloadFileTest extends StatefulWidget {
  const DownloadFileTest({super.key});

  @override
  State<DownloadFileTest> createState() => _DownloadFileTestState();
}

class _DownloadFileTestState extends State<DownloadFileTest> {
  // final _flutterMediaDownloaderPlugin = DownloderTest();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                // Navigator.push(context, MaterialPageRoute(builder: ((context) => ShareTest())));
                // _flutterMediaDownloaderPlugin.downloadMedia(context,
                //     'https://www.kasandbox.org/programming-images/avatars/spunky-sam-green.png');
              },
              child: const Text('Media Download')),
        ),
      ),
    );
  }
}
