import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/main.dart';
import 'package:flutter_complete_guide/question.dart';
import 'package:flutter_complete_guide/script.dart';
import 'package:firebase_database/firebase_database.dart';

class Camera extends StatefulWidget {
  const Camera({Key key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

String path;

class _CameraState extends State<Camera> {
  CameraController controller;
  Future<void> initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.high);

    initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: CameraPreview(controller),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: !controller.value.isRecordingVideo
                    ? RawMaterialButton(onPressed: () async {})
                    : null,
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
