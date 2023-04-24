import 'package:flutter/material.dart';
import 'light2.dart';
import 'tv.dart';
import 'light.dart';

class device extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('DEVICES',style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.lightBlue[200],      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(30.0),
                  height: 100.0,
                  width: 120.0,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Light1()),
                          );
                        },
                        child: Image.asset('assets/light2.png',
                        ),
                      ),

                      Text("Light1")
                    ],
                  ),
                ),


            SizedBox(height: 20,width: 0.0,),
            Container(
              margin: EdgeInsets.all(30.0),
              height: 100.0,
              width: 120.0,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Light2()),
                      );
                    },
                    child: Image.asset('assets/light2.png',
                    ),
                  ),
                  Text("Light2")
                ],
              ),
            ),],),
            SizedBox(height: 20),
            // Row(
            //   children: [
            //     Container(
            //       margin: EdgeInsets.all(30.0),
            //       height: 100.0,
            //       width: 120.0,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.black12,),
            //       child: GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => Tv()),
            //           );
            //         },
            //         child: Image.asset('assets/tv2.png'),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
