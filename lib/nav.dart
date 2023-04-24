import 'package:electrifyy/bill.dart';
import 'package:electrifyy/prediction.dart';
import 'package:flutter/material.dart';


import 'home.dart';
import 'devices.dart';
class nav extends StatefulWidget {
  const nav({Key? key}) : super(key: key);

  @override
  State<nav> createState() => _navState();
}

class _navState extends State<nav> {
  int currentIndex=0;
  final screens=[
    HomePage(),
    device(),
    prediction(),
    bill(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe0e0e0),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors. black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index)=>setState(() {
            currentIndex=index;
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home,),
                label: 'Home',
                //backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(icon: Icon(Icons.devices,),
              label: 'Devices',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.auto_graph),
              label: 'Prediction',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.receipt),
              label: 'Bill',
            ),
          ]),
      body:screens[currentIndex],);
  }
}