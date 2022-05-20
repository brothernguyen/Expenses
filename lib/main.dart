import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './login.dart';
//import 'package:intl/intl.dart';

// void main() => runApp(MyApp());
// void main() => runApp(Login());

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp;
  runApp(Login());
}
