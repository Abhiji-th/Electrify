import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
  class bill extends StatefulWidget {
  @override
  State<bill> createState() => _billState();
}

class _billState extends State<bill> {
  String bill = "Loading...";
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('devices');
  late StreamSubscription billStream;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    billStream = ref.child('bill').onValue.listen((event) {
      final Object? bill1 = event.snapshot.value;
      setState(() {
        bill = '$bill1 Rs';
      });
    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Electricity Bill',style: TextStyle(color: Colors.black),)),
          backgroundColor: Colors.lightBlue[200],        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(25, 70, 25, 100),
          height: 50.0,
          width: 300.0,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Electricity Bill For This Month: $bill',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      );
    }
  @override
  void deactivate() {
    billStream.cancel();
    super.deactivate();
  }
}
