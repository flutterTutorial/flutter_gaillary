import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:story_view/controller/story_controller.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);


class PageViewWIthSlider extends StatefulWidget {
  const PageViewWIthSlider({super.key});

  @override
  _PageViewWIthSliderState createState() => _PageViewWIthSliderState();
}

class _PageViewWIthSliderState extends State<PageViewWIthSlider>  with TickerProviderStateMixin{

late AnimationController controller;
 int _currentPage = 0;

  StoryController storyController = StoryController();
 final playbackNotifier = BehaviorSubject<PlaybackState>();

Timer? _timer;
PageController _pageController = PageController(
  initialPage: 0,
);

@override
void initState() {
  super.initState();
      controller = AnimationController(
      /// [AnimationController]s can be created with vsync: this because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
  _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
    if (_currentPage < 2) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  });
}

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _timer?.cancel();
  }

@override
Widget build(BuildContext context) {
  return PageView(
    controller: _pageController,
    
    children: [
    Column(
    children:[
      Container(
      height:10.0,
        child:LinearProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
      
      ),
      Container(
        child:Text("Page 1")
      ),
    ]
    ),
      
     Column(
    children:[
      Container(
      height:10.0,
        child:LinearProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
      
      ),
      Container(
        child:Text("Page 2")
      ),
    ]
    ),
     Column(
    children:[
      Container(
      height:10.0,
        child:LinearProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
      
      ),
      Container(
        child:Text("Page 3")
      ),
    ]
    ),
],
);
}
}