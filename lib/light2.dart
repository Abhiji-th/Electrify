import 'package:flutter/material.dart';


class Fan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light 2',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightBlue[200],
      ),
      body:  Column(
        children: [
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
              "Units Consumed:",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 0,),
          Container(
            margin: EdgeInsets.fromLTRB(25, 70, 25, 100),
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
}