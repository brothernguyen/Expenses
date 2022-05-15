import 'package:flutter/material.dart';

class Script {
  final int id;
  final String title;
  final String subTitle;

  Script({
    @required this.id,
    @required this.title,
    @required this.subTitle,
  });

  factory Script.fromJson(Map<String, dynamic> json) {
    return Script(
      id: json['id'] as int,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
    );
  }
}
