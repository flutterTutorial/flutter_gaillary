import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;

  List<String> audioUrls = [
    'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
    ' https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba-online-audio-converter.com_-1.wav',
    ' https://www.learningcontainer.com/wp-content/uploads/2020/02/Sample-FLAC-File.flac',
    ' https://www.learningcontainer.com/wp-content/uploads/2020/02/Sample-OGG-File.ogg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: audioUrls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Audio ${index + 1}'),
                  onTap: () {
                    _playAudio(index);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _playAudio(_currentIndex - 1);
                  },
                  child: Icon(Icons.skip_previous),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _playPause();
                  },
                  child: Icon(_audioPlayer.state == PlayerState.paused
                      ? Icons.play_arrow
                      : Icons.pause),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _playAudio(_currentIndex + 1);
                  },
                  child: Icon(Icons.skip_next),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _playPause() {
    if (_audioPlayer.state == PlayerState.playing) {
      _audioPlayer.pause();
    } else if (_audioPlayer.state == PlayerState.paused) {
      _audioPlayer.resume();
    }
  }

  void _playAudio(int index) {
    if (index >= 0 && index < audioUrls.length) {
      _audioPlayer.stop();
      _audioPlayer.play(UrlSource(audioUrls[index]));
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}