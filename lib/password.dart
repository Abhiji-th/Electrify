import 'package:electrifyy/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class password extends StatefulWidget {
  const password({Key? key}) : super(key: key);

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  //TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
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
              Image(image: AssetImage('assets/bulb.gif')),
              SizedBox(height: 10),

              SizedBox(height: 10),
              Container(
               padding: EdgeInsets.only(right: 35,left: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(padding: EdgeInsets.only(right: 35,left: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 52,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      signup();
                      Navigator.pushNamed(context, '/login');
                      //String email = _emailController.text;
                      String password = _passwordController.text;
                      String confirmPassword = _confirmPasswordController.text;
                    },
                    child: Text('SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );

  }
  // Future signUp() async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => Center(child : CircularProgressIndicator()),
  //   );
  //
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _email,
  //       password: _passwordController.text.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  //
  //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
  //
  // }
}