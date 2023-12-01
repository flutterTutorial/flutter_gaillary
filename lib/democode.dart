import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class ImageGroup {
  List<String> imagePaths;

  ImageGroup({required this.imagePaths});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ImageGroup> imageGroups = [
    ImageGroup(imagePaths: []),
    ImageGroup(imagePaths: []),
    // Add more ImageGroup instances as needed
  ];

  Future<void> _pickImage(int groupIndex) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageGroups[groupIndex].imagePaths.add(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Demo'),
      ),
      body: ListView.builder(
        itemCount: imageGroups.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Image Group $index'),
            trailing: IconButton(
              icon: Icon(Icons.camera),
              onPressed: () => _pickImage(index),
            ),
            subtitle: SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageGroups[index].imagePaths.length,
                itemBuilder: (context, subIndex) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.file(
                      File(imageGroups[index].imagePaths[subIndex]),
                      height: 80.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
