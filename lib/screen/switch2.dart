import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MyData> data = List.generate(5, (index) => MyData(index, false));
  List<Map<String, dynamic>> collectedData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Buttons Example'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${data[index].index}'),
            trailing: Switch(
              value: data[index].isSwitched,
              onChanged: (value) {
                setState(() {
                  data[index].isSwitched = value;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Collect data and store in array
          for (var item in data) {
            collectedData.add({
              'index': item.index,
              'isSwitched': item.isSwitched,
              // You can include other data fields here if needed
            });
          }

          // Print the collected data
          print(collectedData);

          // Reset collected data for the next submission
          collectedData.clear();
        },
        child: Icon(Icons.send),
      ),
    );
  }
}

class MyData {
  final int index;
  bool isSwitched;

  MyData(this.index, this.isSwitched);
}
