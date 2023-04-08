import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/login');
    });
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(120,250,50,100),
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage('assets/home2.png'
                      ''),
                  height: 50.0,
                  width: 50.0,
                ),
              ),
              Container(
                child: Text('ElectriFY',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30.0),),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Text('Know Your Electricity Bill',style: TextStyle(color: Colors.black,fontSize: 10.0),),
              ),
              Container(
                child: Text('Anytime...Anywhere..',style: TextStyle(color: Colors.black,fontSize: 10.0),),
              ),
            ],
          )

      ),
    );
  }
}