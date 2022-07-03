import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import './video_player.dart';

class VideoRecording extends StatefulWidget {
  final Function callback;

  VideoRecording({Key? key, required this.callback}) : super(key: key);

  @override
  _VideoRecordingState createState() => _VideoRecordingState();
}

class _VideoRecordingState extends State<VideoRecording> {
  bool _isLoading = true;
  bool _isRecording = false;
  String _recordedVideo = '';
  late CameraController _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      // _recordedVideo = Path.basename(file.path);
      _recordedVideo = file.path;
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(
          filePath: file.path,
          acceptRecordedVideo: saveRecordedVideo,
        ),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  saveRecordedVideo() {
    widget.callback(_recordedVideo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Video Recording'),
          centerTitle: true,
          elevation: 0,
          // backgroundColor: Colors.black26,
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(_isRecording ? Icons.stop : Icons.circle),
                  onPressed: () => _recordVideo(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
