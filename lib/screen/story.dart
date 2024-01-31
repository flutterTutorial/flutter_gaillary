import 'package:flutter/material.dart';
import 'package:flutter_gallery/screen/story_example.dart';
import 'package:story_view/story_view.dart';
import 'package:rxdart/rxdart.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final StoryController controller = StoryController();

  final playbackNotifier = BehaviorSubject<PlaybackState>();

  List<StoryItem> stories = [];

  List<String> storiesData = [
    "https://i.pinimg.com/originals/f6/eb/53/f6eb535411056b553dfdec1665387c0c.jpg",
    "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
    "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
    "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif"
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < storiesData.length; i++) {
      setState(() {
        stories.add(
          StoryItem.pageImage(
            controller: controller,
            url: storiesData[i],
            caption: "Simply beautiful😘😘😘",
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delicious Ghanaian Meals"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StoryExamplePage()));
              },
              icon: const Icon(Icons.abc))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(
          8,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              child: StoryView(
                controller: controller,
                storyItems: stories,
                onStoryShow: (s) {
                  print("Showing a story");
                },
                onComplete: () {
                  print("Completed a cycle");
                  Navigator.pop(context);
                },
                progressPosition: ProgressPosition.bottom,
                repeat: false,
                inline: true,
              ),
            ),
            // Material(
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => MoreStories()));
            //     },
            //     child: Container(
            //       decoration:const BoxDecoration(
            //           color: Colors.black54,
            //           borderRadius:
            //               BorderRadius.vertical(bottom: Radius.circular(8))),
            //       padding:const EdgeInsets.symmetric(vertical: 8),
            //       child: const Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Icon(
            //             Icons.arrow_forward,
            //             color: Colors.white,
            //           ),
            //           SizedBox(
            //             width: 16,
            //           ),
            //           Text(
            //             "View more stories",
            //             style: TextStyle(fontSize: 16, color: Colors.white),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "I guess you'd love to see more of our food. That's great.",
            backgroundColor: Colors.blue,
          ),
          StoryItem.text(
            title: "Nice!\n\nTap to continue.",
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontFamily: 'Dancing',
              fontSize: 40,
            ),
          ),
          StoryItem.pageImage(
            url:
                "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
            caption: "Still sampling",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
              caption: "Working with gifs",
              controller: storyController),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side",
            controller: storyController,
          ),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side2",
            controller: storyController,
          ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        inline: true,
        controller: storyController,
      ),
    );
  }
}
