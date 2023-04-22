import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class Light2 extends StatefulWidget {
  @override
  State<Light2> createState() => _Light2State();
}

class _Light2State extends State<Light2> {

  String dispcurrent = 'Loading...';
  String dispvoltage = 'Loading...';
  String disppower = 'Loading...';
  String dispenergy = 'Loading...';
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('devices');
  late StreamSubscription currentStream;
  late StreamSubscription voltageStream;
  late StreamSubscription powerStream;
  late StreamSubscription energyStream;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    currentStream = ref.child('bulb2/current').onValue.listen((event) {
      final Object? current = event.snapshot.value;
      setState(() {
        dispcurrent = '$current';
      });
    });
    voltageStream = ref.child('bulb2/voltage').onValue.listen((event) {
      final Object? voltage = event.snapshot.value;
      setState(() {
        dispvoltage = '$voltage';
      });
    });
    powerStream = ref.child('bulb2/power').onValue.listen((event) {
      final Object? power = event.snapshot.value;
      setState(() {
        disppower = '$power';
      });
    });
    energyStream = ref.child('bulb2/energy').onValue.listen((event) {
      final Object? energy = event.snapshot.value;
      setState(() {
        dispenergy = '$energy';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BULB 2',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightBlue[200],
      ),
      body:  Column(
        children: [

          //Current
          Container(
            margin: EdgeInsets.fromLTRB(25, 70, 25,0),
            height: 50.0,
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              "Current : $dispcurrent",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Voltage
          Container(
            margin: EdgeInsets.fromLTRB(25, 20, 25,0),
            height: 50.0,
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              "Voltage : $dispvoltage",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Power
          Container(
            margin: EdgeInsets.fromLTRB(25, 20, 25,0),
            height: 50.0,
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              "Power : $disppower",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Energy
          Container(
            margin: EdgeInsets.fromLTRB(25, 20, 25,0),
            height: 50.0,
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              "Energy : $dispenergy",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Units
          Container(
            margin: EdgeInsets.fromLTRB(25, 20, 25,0),
            height: 50.0,
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              "Units : ",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Cost
          Container(
            margin: EdgeInsets.fromLTRB(25, 20, 25, 100),
            height: 50.0,
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Cost:',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void deactivate() {
    currentStream.cancel();
    voltageStream.cancel();
    powerStream.cancel();
    energyStream.cancel();
    super.deactivate();
  }
}