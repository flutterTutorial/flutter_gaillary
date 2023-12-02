import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardModel {
  List<String> images = [];
}

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  List<CardModel>? cards = List.generate(10, (index) => CardModel());

  CardList({this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards!.length,
      itemBuilder: (context, index) {
        return CardWidget(card: cards![index]);
      },
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
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Display existing images
          for (var image in widget.card.images) Image.network(image),

          // Upload Image Button
          ElevatedButton(
            onPressed: () {
              _showImagePicker(context);
            },
            child: const Text('Upload Image'),
          ),
        ],
      ),
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
