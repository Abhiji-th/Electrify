import 'package:flutter/material.dart';


class Fan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAN',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Text('FAN'),
      ),
    );
  }
}