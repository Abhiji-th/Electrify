import 'package:electrifyy/database.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final pnumController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    pnumController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void main() =>
      runApp(MyApp());
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
        child: Form(
          key: formKey,
          child: Center(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset("assets/bulb.gif", height: 122),

                // Name text field
                Container(
                  padding: const EdgeInsets.only(bottom: 10,left: 35,right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                ),

                // Consumer ID field
                Container(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: idController,
                    decoration: InputDecoration(
                      labelText: 'Consumer ID',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Enter Consumer ID';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),

                // Phone number field
                Container(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: pnumController,
                    decoration: InputDecoration(
                      labelText: 'Phone no.',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter Phone no ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),

                // Email field
                Container(
                  padding: EdgeInsets.only(left: 35,right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode : AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
                  ),
                ),
                SizedBox(height: 10),

                // Password field
                Container(
                  padding: EdgeInsets.only(right: 35,left: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min. 6 characters'
                        : null,
                  ),
                ),
                SizedBox(height: 10),

                // Confirm password field
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please re-enter password';
                      }
                      // print(passwordController.text);
                      //
                      // print(confirmPasswordController.text);

                      if(passwordController.text!=confirmPasswordController.text){
                        return "Password does not match";
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),

                // Sign in button
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: SizedBox(
                    height: 52,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          signUp();
                        }
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
                ),],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try{
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData(
          nameController.text.trim(),
          idController.text.trim(),
          pnumController.text.trim()
      );

    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message!);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

