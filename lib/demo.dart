import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class IndexedImage {
  int index;
  XFile? imageFile; // Use XFile from image_picker package

  IndexedImage({required this.index, this.imageFile});
}

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  List<IndexedImage> indexedImages = [];

  Future<void> _pickImage(int index) async {
    final imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        indexedImages.add(IndexedImage(index: index, imageFile: image));
      });
    }
  }

  Future<void> _uploadImages() async {
    // Replace with your server endpoint for image upload
    final String uploadUrl = 'https://your-api-endpoint.com/upload';

    for (IndexedImage indexedImage in indexedImages) {
      if (indexedImage.imageFile != null) {
        var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            indexedImage.imageFile!.path,
          ),
        );
        request.fields['index'] = indexedImage.index.toString();

        try {
          final response = await request.send();
          if (response.statusCode == 200) {
            print(
                'Image uploaded successfully for index ${indexedImage.index}');
          } else {
            print('Failed to upload image for index ${indexedImage.index}');
          }
        } catch (error) {
          print('Error uploading image: $error');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:
                  10, // Replace with the total number of indices you want
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Index $index'),
                  trailing: IconButton(
                    icon: Icon(Icons.upload),
                    onPressed: () => _pickImage(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _uploadImages,
            child: Text('Upload Images'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImageUploadWidget(),
  ));
}
