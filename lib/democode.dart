import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardModel {
  List<String> images = [];
}

class ImageTest extends StatefulWidget {
  ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  final List<CardModel> cards = List.generate(10, (index) => CardModel());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card Image Upload'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return CardWidget(card: cards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final CardModel card;

  CardWidget({required this.card});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _showImagePicker(context);
          },
          child: const Text('Upload Image'),
        ),
        Container(
          height: 300.0, // Set a fixed height for the container
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.card.images.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100.0, // Set a fixed height for the image container
                child: Image.file(
                  File(widget.card.images[index]),
                  height: 100.0,
                  width: 100.0,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showImagePicker(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      // Update the 'images' list with the selected images
      setState(() {
        widget.card.images
            .addAll(pickedFiles.map((file) => file.path).toList());
      });
    }
  }
}
