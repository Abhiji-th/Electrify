import 'package:flutter/material.dart';
  class bill extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Electricity Bill',style: TextStyle(color: Colors.black),)),
          backgroundColor: Colors.lightBlue[200],        ),
        body: Center(
          child: Text('Bill amount  for this month'),
        ),
      );
    }
  }
