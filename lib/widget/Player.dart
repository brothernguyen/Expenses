import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class Player extends StatefulWidget {
  int id;
  VideoPlayerController videoPlayerController;

  Player(int id, VideoPlayerController videoPlayerController, {Key key})
      : super(key: key) {
    this.id = id;
    this.videoPlayerController = videoPlayerController;
  }

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  String videoId;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    videoId = widget.id.toString();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chewie(controller: _chewieController),
      ),
    );
  }
}

class VideoDisplay extends StatefulWidget {
  String videoUrl;
  int index;
  VideoDisplay(this.index, this.videoUrl, {Key key}) : super(key: key) {
    this.index = index;
  }

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Player(
            widget.index,
            VideoPlayerController.network(
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')));
  }
}
