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

class Question {
  int id;
  String title;
  String description;
  String startDate;
  String endDate;
  String img;
  bool isCompleted;
  List questions;

  Question({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.startDate,
    @required this.endDate,
    @required this.img,
    @required this.isCompleted,
    @required this.questions,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        startDate: json['startDate'] as String,
        endDate: json['endDate'] as String,
        img: json['img'] as String,
        isCompleted: json['isCompleted'] as bool,
        questions: json['questions'] as List<SubQuestion>);
  }
}

class SubQuestion {
  String title;
  QuestionType type;
  List options;
}
