import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  int id;
  VideoPlayer(int id, {Key key}) : super(key: key) {
    this.id = id;
  }

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  String videoId;

  @override
  Widget build(BuildContext context) {
    videoId = widget.id.toString();
    return Container();
  }
}
