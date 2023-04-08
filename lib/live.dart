import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
class live extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Consumption',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Column(
       children: [
         SizedBox(height: 50.0,width: 100.0,),
         SafeArea(
           child: SizedBox(width: 350.0,
             child: SimpleCircularProgressBar(
               progressColors: const [Colors.cyan],
    onGetText: (double value) {
    return Text('${value.toInt()}%');},
               mergeMode: true,
             ),
           ),
         ),
       ],
      ),
    );
  }
}