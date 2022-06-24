import 'dart:io';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/main.dart';
import 'package:flutter_complete_guide/question.dart';
import 'package:flutter_complete_guide/script.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';

import 'api/firebase_api.dart';
import 'widget/button_widget.dart';

class Camera extends StatefulWidget {
  int index;
  Camera(int index, {Key key}) : super(key: key) {
    this.index = index;
  }

  @override
  State<Camera> createState() => _CameraState();
}

String path;

class _CameraState extends State<Camera> {
  UploadTask task;
  File file;
  int index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    file = null;
  }

  @override
  Widget build(BuildContext context) {
    print('==>index: $index');
    final fileName = file != null ? basename(file.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: () {
                  file != null ? uploadFile(context) : null;
                },
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }

  Future uploadFile(BuildContext context) async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = '$fileName';
    var snapshot = null;
    String videoUrl = '';

    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;
    try {
      snapshot = await task.whenComplete(() {});
      videoUrl = await snapshot.ref.getDownloadURL();
      print('Download-Link: $videoUrl');
    } catch (error) {
      print('==>error: $error');
      displayDialog(context);
    }
    // final snapshot = await task.whenComplete(() {});
    // final videoUrl = await snapshot.ref.getDownloadURL();

    if (!videoUrl.isEmpty) {
      final id = index.toString();
      final DBRef = FirebaseDatabase.instance.ref();
      await DBRef.child('scripts/$id/').update({'videoUrl': videoUrl});

      setState(() {
        file = null;
      });
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  displayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Server error!'),
        content: const Text('Please try it again'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
