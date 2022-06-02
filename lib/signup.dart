import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final VoidCallback showLoginPage;

  const SignUp({Key key, this.showLoginPage}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password == confirmPassword) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } else {
      print('wrong confirm password!!!');
    }
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
                          decoration: InputDecoration(labelText: 'Password'),
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                        ),
                        TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          keyboardType: TextInputType.number,
                          controller: confirmPasswordController,
                        ),
                        const SizedBox(height: 30),
                        Platform.isIOS
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        signUp();
                                      },
                                      child: const Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.deepOrange,
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'I am a member! ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: widget.showLoginPage,
                                          child: Text(
                                            'Login now',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                        signUp();
                                      },
                                      child: const Text('SIGN UP'),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'I am a member! ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: widget.showLoginPage,
                                          child: Text(
                                            'Login now',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
