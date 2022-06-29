import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './login.dart';
import './mainScreen.dart';
import './cardDetail.dart';
import './auth.dart';
import './script.dart';
import './camera.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:intl/intl.dart';

// void main() => runApp(MyApp());
// void main() => runApp(Login());

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(NavRoot());
}

class NavRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => Auth(),
        '/main_screen': (context) => MainScreen(),
        //'/camera_screen': ((context) => Camera())
        //'/detail_screen': (context) => CardDetail(),
      },
    );
  }
}
