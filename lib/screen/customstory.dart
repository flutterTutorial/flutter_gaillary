import 'dart:async';
import 'package:flutter/material.dart';

class CustomStory extends StatefulWidget {
  const CustomStory({super.key});

  @override
  _CustomStoryState createState() => _CustomStoryState();
}

class _CustomStoryState extends State<CustomStory> {
  int currentIndex = 0;
  final List<String> items = ["Item 1", "Item 2", "Item 3", "Item 4"];
  final PageController _pageController = PageController();
  Timer? timer;
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        progressValue += 0.01;
        if (progressValue >= 1.0) {
          // If progress reaches 100%, change page
          currentIndex = (currentIndex + 1) % items.length;
          _pageController.animateToPage(
            currentIndex,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          progressValue = 0.0;

          // Check if the entire list has been cycled through
          if (currentIndex == 0) {
            print("Complete");
          }
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void resetProgress() {
    setState(() {
      progressValue = 0.0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto-changing PageView with Smooth LinearProgressBar"),
      ),
      body: GestureDetector(
        onLongPressStart: (_) {
          stopTimer();
        },
        onLongPressMoveUpdate: (_) {
          // Handle drag/move events during long press if needed
        },
        onLongPressEnd: (_) {
          startTimer();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progressValue,
              minHeight: 10,
            ),
            SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      items[index],
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
