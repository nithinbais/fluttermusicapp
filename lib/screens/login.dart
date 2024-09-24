import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const platform = MethodChannel('apidata');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? deviceToken;
  String _response = '';
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();
  }

  Future<String> getDeviceToken() async {
    deviceToken = await messaging.getToken();
    print('----deviceToken-----${deviceToken}');
    return deviceToken ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 9,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/logomic.png',
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'SIGN IN',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'TO CONTINUE',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                width:
                    MediaQuery.of(context).size.width * 0.9, // Adjusted width
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    labelText: 'Enter your Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width:
                    MediaQuery.of(context).size.width * 0.9, // Adjusted width
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    labelText: 'Enter your Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  _fetchDataFromApi();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Center(
                      child: _isLoading == false
                          ? Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )
                          : CircularProgressIndicator(
                              color: Colors.white,
                            )),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple]),
                      borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                  onPressed: () {
                    showCustomToast('Forget Password?');
                  },
                  child: Text('Lost Password?')),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/logogoogle.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Google',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/logofacebook.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Facebook',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {
                        showCustomToast('Register');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
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

  Future<void> _fetchDataFromApi() async {
    _isLoading == true;

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showCustomToast("Email and Password must not be empty");
      return;
    }

    try {
      final String result = await platform.invokeMethod('fetchDataFromApi', {
        "email": email,
        "password": password,
        "device_token": deviceToken,
        "device_type": "android"
      });
      final Map<String, dynamic> response = jsonDecode(result);

      setState(() {
        _response = response.toString();
        print(response);
      });
      if (response['status_code'] == 200) {
        _isLoading == false;
        showCustomToast('Login successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } catch (e) {
      setState(() {
        showCustomToast('error');
        _response = "Failed to fetch data: '${e}'.";
        _isLoading == false;
      });
    }
  }
}
