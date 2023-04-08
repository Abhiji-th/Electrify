import 'package:electrifyy/database.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  late String name,CId,phone;
  final formKey = GlobalKey<FormState>();
  final CIdController = TextEditingController();
  final pnumController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //TextEditingController _confirmPasswordController = TextEditingController();
  @override
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
                Container(
                  padding: const EdgeInsets.only(bottom: 10,left: 35,right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
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
                    onSaved: (String? value){
                      name = value!;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
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
                    onSaved: (String? value){
                      CId = value!;
                    },
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(right: 35,left: 35),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       hintText: 'Consumer ID',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(5)
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFFFFF),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
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
                    onSaved: (String? value){
                      phone = value!;
                    },
                  ),
                ),
                SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 35,right: 35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFFFFF),
                      ),
                      child: TextFormField(
                        controller: _emailController,
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
          Container(
            padding: EdgeInsets.only(right: 35,left: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFFFFF),
            ),
            child: TextFormField(
              controller: _passwordController,
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
          Padding(
            padding: const EdgeInsets.only(left: 35,right: 35),
            child: TextFormField(
              controller: _confirmPasswordController,
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
                print(_passwordController.text);

                print(_confirmPasswordController.text);

                if(_passwordController.text!=_confirmPasswordController.text){
                  return "Password does not match";
                }

                return null;
              },

            ),
          // Container(padding: EdgeInsets.only(right: 35,left: 35),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     color: Colors.white,
          //   ),
          //   child: TextField(
          //     controller: _confirmPasswordController,
          //     obscureText: true,
          //     decoration: InputDecoration(
          //       labelText: 'Confirm Password',
          //       border: OutlineInputBorder(),
          //     ),
          //   ),
          ),
          SizedBox(height: 10),
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
           email: _emailController.text.trim(),
           password: _passwordController.text.trim(),
       );
       // User? user = result.user;
       // String CId = CIdController as String;
       // int pnum = pnumController as int;
       // await DatabaseService(uid: user!.uid).updateUserData('123456',12345678);
     } on FirebaseAuthException catch (e) {
       print(e);
     }
     navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }


