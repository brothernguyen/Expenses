import 'package:flutter/material.dart';
import './mainScreen.dart';
//import 'package:flutter_complete_guide/transaction.dart';
//import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import './transaction.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  final emailController = TextEditingController();
  final pinController = TextEditingController();
  LoginForm({Key key}) : super(key: key);

  void handleInput(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  _launchForgotPinURLBrowser() async {
    const url = 'https://www.vidlet.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo-vidlet-butterfly.png'),
      ),
      body: Container(
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
                          decoration: InputDecoration(labelText: 'PIN'),
                          keyboardType: TextInputType.number,
                          controller: pinController,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
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
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            primary: Color(0xFF660033),
                          ),
                          onPressed: () {},
                          child: const Text('JOIN OURS EXPERTS'),
                        ),
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
                                onPressed: () {},
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
