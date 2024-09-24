import 'package:flutter/material.dart';
import 'package:flutterproject/screens/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 9,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logomic.png',
              width: 100,
              height: 100,
              color: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'WELCOME TO',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'MUSIC',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              TextSpan(
                text: ' APP ',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 50),
              ),
            ])),
            const SizedBox(
              height: 70,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text('Log In'),
                  style:
                      OutlinedButton.styleFrom(backgroundColor: Colors.white),
                )),
            const SizedBox(
              height: 15,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    showCustomToast('Register');
                  },
                  child: Text('Register'),
                  style:
                      OutlinedButton.styleFrom(backgroundColor: Colors.white),
                )),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Or quick login',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              'with Touch ID',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/fingerprint.png',
              width: 100,
              height: 100,
              color: Colors.white,
            ),
          ],
        ),
      )),
    );
  }

  void showCustomToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
