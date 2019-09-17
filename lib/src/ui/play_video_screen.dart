import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  final String path;
  PlayVideoScreen({this.path});
  @override
  State<StatefulWidget> createState() => PlayVideoScreenState();
}

class PlayVideoScreenState extends State<PlayVideoScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: YoutubePlayer(
            context: context,
            videoId: widget.path,
            flags: YoutubePlayerFlags(
              disableDragSeek: true,
              mute: false,
              autoPlay: false,
              forceHideAnnotation: true,
              showVideoProgressIndicator: true,
            ),
            videoProgressIndicatorColor: Colors.redAccent,
            progressColors: ProgressColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
