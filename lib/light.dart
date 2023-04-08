import 'package:flutter/material.dart';
class Light extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIGHT',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Text('LIGHT'),
      ),
    );
  }
}
