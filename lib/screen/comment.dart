import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;

  // Future _pickImage() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       imageFile = File(pickedImage.path);
  //     });
  //   }
  // }
  Future _pickImage() async {
    var permissionStatus = await Permission.photos.request();

    if (permissionStatus.isGranted) {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
        });
      }
    } else {
      // Handle denied permissions
      if (permissionStatus.isDenied) {
        // Permission was denied once, request again or inform the user why it's necessary
      } else if (permissionStatus.isPermanentlyDenied) {
        // Handle permanent denial by opening app settings
        openAppSettings();
      }
    }
  }


  Future _cropImage() async {
    if (imageFile != null) {
      var cropped = await ImageCropper().cropImage(
          sourcePath: imageFile!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Crop',
                cropGridColor: Colors.black,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
                IOSUiSettings(
              title: 'Crop',
            )
          ],
          // androidUiSettings: AndroidUiSettings(
          //     toolbarTitle: 'Crop',
          //     cropGridColor: Colors.black,
          //     initAspectRatio: CropAspectRatioPreset.original,
          //     lockAspectRatio: false),
          // iosUiSettings: IOSUiSettings(
          //   title: 'Crop',
          // )
          );

      if (cropped != null) {
        setState(() {
          imageFile = File(cropped.path);
        });
      }
    }
  }

  void _clearImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Crop Your Image")),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: imageFile != null
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Image.file(imageFile!))
                    : const Center(
                        child: Text("Add a picture"),
                      )),
            Expanded(
                child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconButton(icon: Icons.add, onpressed: _pickImage),
                  _buildIconButton(icon: Icons.crop, onpressed: _cropImage),
                  _buildIconButton(icon: Icons.clear, onpressed: _clearImage),
                ],
              ),
            ))
          ],
        ));
  }

  Widget _buildIconButton(
      {required IconData icon, required void Function()? onpressed}) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          onPressed: onpressed,
          icon: Icon(icon),
          color: Colors.white,
        ));
  }
}
//////////////////////
class MusicPlayer {
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> playlist = [
    "song1.mp3",
    "song2.mp3",
    // Add more songs as needed
  ];
  int currentIndex = 0;

  Future<void> play() async {
    await audioPlayer.play(playlist[currentIndex], isLocal: true);
  }

  Future<void> playNext() async {
    if (currentIndex < playlist.length - 1) {
      await audioPlayer.stop();
      currentIndex++;
      await play();
    }
  }

  Future<void> playPrevious() async {
    if (currentIndex > 0) {
      await audioPlayer.stop();
      currentIndex--;
      await play();
    }
  }
}

class MusicPlayerScreen extends StatelessWidget {
  final MusicPlayer player = MusicPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                player.play();
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                player.playNext();
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_previous),
              onPressed: () {
                player.playPrevious();
              },
            ),
          ],
        ),
      ),
    );
  }
}