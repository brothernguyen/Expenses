import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './login.dart';
import './mainScreen.dart';
import './cardDetail.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:intl/intl.dart';

// void main() => runApp(MyApp());
// void main() => runApp(Login());

Future main() async {
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
        '/': (context) => Login(),
        '/main_screen': (context) => MainScreen(),
        '/detail_screen': (context) => CardDetail(),
      },
    );
  }
}
