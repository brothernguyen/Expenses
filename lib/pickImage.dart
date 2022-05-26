import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File _storedImage;

  Future<void> takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Pick Image from Gallery",
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: takePicture,
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Pick Image from Camera",
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}
