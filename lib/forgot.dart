import 'package:flutter/material.dart';

import 'buttons.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xFFFFFF),
              const Color(0xFFFFFF),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Forgot Password",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
              SizedBox(height: 50),
              Text("code has been sent to shai****46@gmail.com",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),),
              SizedBox(height: 50),
              Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),),
                    AppButtons(textColor: Colors.black,
                      backgroundColor: Colors.white,
                      borderColor: Colors.black,
                      text: "*",
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),),
                    AppButtons(textColor: Colors.black,
                      backgroundColor: Colors.white,
                      borderColor: Colors.black,
                      text: "*",
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),),
                    AppButtons(textColor: Colors.black,
                      backgroundColor: Colors.white,
                      borderColor: Colors.black,
                      text: "*",
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),),
                    AppButtons(textColor: Colors.black,
                      backgroundColor: Colors.white,
                      borderColor: Colors.black,
                      text: "*",
                      size: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text("Resend code in 53s..",
                style: TextStyle(color: Colors.black),),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                child: Text('Verify',
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
