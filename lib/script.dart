import 'dart:ffi';

import 'package:flutter/material.dart';

class Script {
  int id;
  String title;
  String subTitle;
  String first_name;
  String last_name;
  String email;
  String img;
  bool isPublished;

  Script({
    @required this.id,
    @required this.title,
    @required this.subTitle,
    @required this.first_name,
    @required this.last_name,
    @required this.email,
    @required this.img,
    @required this.isPublished,
  });

  factory Script.fromJson(Map<String, dynamic> json) {
    return Script(
        id: json['id'] as int,
        title: json['title'] as String,
        subTitle: json['subTitle'] as String,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        email: json['email'] as String,
        img: json['img'] as String,
        isPublished: json['isPublished'] as bool);
  }
}
