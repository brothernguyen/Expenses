import 'dart:ffi';

import 'package:flutter/material.dart';

enum QuestionType {
  WELCOME,
  VIDEO,
  TEXT,
  NUMERIC,
  SINGLE_CHOICE,
  MULTIPLE_CHOICE,
  THANKYOU
}

class Script {
  int id;
  String title;
  String description;
  String startDate;
  String endDate;
  String img;
  bool isCompleted;
  List questions;

  Script({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.startDate,
    @required this.endDate,
    @required this.img,
    @required this.isCompleted,
    @required this.questions,
  });

  // factory Script.fromJson(dynamic json) {
  //   return Script(
  //       id: json['id'] as int,
  //       title: json['title'] as String,
  //       description: json['description'] as String,
  //       startDate: json['startDate'] as String,
  //       endDate: json['endDate'] as String,
  //       img: json['img'] as String,
  //       isCompleted: json['isCompleted'] as bool,
  //       questions: json['questions']);
  // }

  factory Script.fromJson(Map<String, dynamic> json) {
    return Script(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        startDate: json['startDate'] as String,
        endDate: json['endDate'] as String,
        img: json['img'] as String,
        isCompleted: json['isCompleted'] as bool,
        questions: json['questions']);
  }
}

class SubQuestion {
  String title;
  String type;
  List<String> options;

  SubQuestion(
      {@required this.title, @required this.type, @required this.options});
  factory SubQuestion.fromJson(Map<String, dynamic> json) {
    return SubQuestion(
        title: json['title'] as String,
        type: json['type'],
        options: json['options'] as List<String>);
  }
}
