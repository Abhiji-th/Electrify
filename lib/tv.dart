import 'package:flutter/material.dart';

class Tv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Text('TV'),
      ),
    );
  }
}
