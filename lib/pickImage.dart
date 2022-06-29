import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  late File _storedImage;

  Future<void> takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600);
    print(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // MaterialButton(
          //   color: Colors.blue,
          //   child: Text(
          //     "Pick Image from Gallery",
          //     style:
          //         TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          //   ),
          //   onPressed: takePicture,
          // ),
          CupertinoButton(
            onPressed: takePicture,
            child: const Text(
              "Pick Image from Gallery",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            color: Colors.blueAccent,
          ),
        ],
      ),
    ));
  }
}
