import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  const ChewieListItem(
      {Key? key, required this.videoPlayerController, required this.looping})
      : super(key: key);

  @override
  State<ChewieListItem> createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 9 / 16,
        autoInitialize: true,
        autoPlay: true,
        looping: widget.looping,
        // placeholder: Container(
        //   color: Color.fromRGBO(255, 255, 255, 1.0),
        //   child: Container(
        //     child: Center(
        //         child: CircularProgressIndicator(
        //       valueColor: new AlwaysStoppedAnimation<Color>(
        //           Color.fromARGB(221, 202, 76, 13)),
        //     )),
        //   ),
        // ),
        errorBuilder: (context, errorMessage) {
          print('==>: $errorMessage');
          return Center(
            child: Text(
              // errorMessage,
              'Video URL invalid!',
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Video Player'),
            automaticallyImplyLeading: true,
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        : AppBar(title: Text('Video Player'), actions: <Widget>[])
            as PreferredSizeWidget;

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
