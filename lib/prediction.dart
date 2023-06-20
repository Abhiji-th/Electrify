import 'dart:async';
import 'dart:convert';
import 'package:electrifyy/function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class prediction extends StatefulWidget {
  @override
  State<prediction> createState() => _predictionState();
}

class _predictionState extends State<prediction> {

  String url='http://192.168.1.6:5000/api';
  var data;
  String output = 'Loading...';
  String disppredicted = 'Loading...';
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('predicted_energy');
  late StreamSubscription predictedStream;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    predictedStream = ref.child('bill').onValue.listen((event) {
      final Object? predicted = event.snapshot.value;
      setState(() {
        disppredicted = '$predicted Rs';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Bill Prediction',style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.lightBlue[200],      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(25, 70, 25, 100),
            height: 50.0,
            width: 300.0,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Predicted Bill for this month : $output Rs',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
    SizedBox(height: 60.0,),
    Center(
    child: TextButton(
    onPressed: () async{

        try {
          data = await fetchdata(url);
          var decoded = jsonDecode(data);
          setState(() {
            output = decoded['output'];
          });
        } catch (error) {
          Fluttertoast.showToast(msg: error.toString());
        }

    },
    style: TextButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Colors.blue,
    ),
    child: Text(
    'PREDICT BILL',
    style: TextStyle(fontSize: 16.0),
    ),
    ),
    ),
        ],
      )
    );
  }
  @override
  void deactivate() {
    predictedStream.cancel();
    super.deactivate();
  }
}