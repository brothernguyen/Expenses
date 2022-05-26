import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return LoginForm();
        });
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final pinController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pinController.dispose();
    super.dispose();
  }

  Future handleInput(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          // email: emailController.text.trim(),
          // password: pinController.text.trim());
          email: 'a@a.com',
          password: '111111');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text('Login Failed'),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(e.message),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }

  _launchForgotPinURLBrowser() async {
    const url = 'https://www.vidlet.com/';
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showHelpDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Need help?'),
            actions: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bug_report_rounded,
                              size: 20, color: Colors.blue),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              textStyle: TextStyle(fontSize: 14),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Report a bug',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline,
                              size: 20, color: Colors.blue),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              textStyle: TextStyle(fontSize: 14),
                            ),
                            onPressed: () {},
                            child: Text('Suggest an improvement'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.question_mark_rounded,
                              size: 20, color: Colors.blue),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              textStyle: TextStyle(fontSize: 14),
                            ),
                            onPressed: () {},
                            child: Text('Ask a question'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo-vidlet-butterfly.png'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 0,
                borderOnForeground: false,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(labelText: 'PIN'),
                          keyboardType: TextInputType.number,
                          controller: pinController,
                        ),
                        const SizedBox(height: 30),
                        Platform.isIOS
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        handleInput(context);
                                      },
                                      child: const Text(
                                        'LOG IN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.deepOrange,
                                    ),
                                    const SizedBox(height: 10),
                                    CupertinoButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'JOIN OURS EXPERTS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Color(0xFF660033),
                                    )
                                  ])
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 20,
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        primary: Colors.deepOrange,
                                      ),
                                      onPressed: () {
                                        handleInput(context);
                                      },
                                      child: const Text('LOG IN'),
                                    ),
                                    const SizedBox(height: 5),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 20,
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        primary: Color(0xFF660033),
                                      ),
                                      onPressed: () {},
                                      child: const Text('JOIN OURS EXPERTS'),
                                    )
                                  ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              padding: EdgeInsets.all(2),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                                onPressed: () {
                                  showHelpDialog(context);
                                },
                                child: const Text('Help'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              padding: EdgeInsets.all(2),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                                onPressed: () {
                                  _launchForgotPinURLBrowser();
                                },
                                child: const Text('Forgot PIN'),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
