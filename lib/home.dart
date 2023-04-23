import 'dart:async';

import 'package:electrifyy/database.dart';
import 'package:electrifyy/profile.dart';
import 'package:electrifyy/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'header_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMounted = false;
  String totalConsumption = "Loading...";
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('devices');
  late StreamSubscription totalStream;

  @override
  void initState() {
    super.initState();
    isMounted = true;
    activateListeners();
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  void activateListeners() {
    totalStream = ref.child('totalEnergy').onValue.listen((event) {
      final Object? totalEnergy = event.snapshot.value;
      setState(() {
        totalConsumption = '$totalEnergy Kwh';
      });
    });
  }

  var currentPage = DrawerSections.profile;
  final user = FirebaseAuth.instance.currentUser!;

  String name = 'Loading...';
  String id = 'Loading...';
  String pnum = 'Loading...';

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService(uid: user.uid);
    Future getData() async {
      dynamic names = await databaseService.getCurrentUserData();
      if (names != null) {
        if (isMounted) {
          setState(() {
            name = "Welcome ${names[0]} !";
            id = names[1];
            pnum = names[2];
          });
        }
      }
    }

    getData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30.0,
          ),

          //Profile
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue[100]),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10,20,20,20),
                  child: CircleAvatar(
                    child: Image.asset('assets/man.gif'),
                  ),
                ),
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10),
                        Text("Cosumer ID : $id",
                          textAlign: TextAlign.start,
                          style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10),
                        Text("Phone Number : $pnum",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),)
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),

          //Total consumption
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[100]),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: [
                Text('Total Energy Consumed : $totalConsumption',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                ) ),
                SizedBox(
                  width: 20.0,
                ),
                // SimpleCircularProgressBar(
                //   mergeMode: true,
                //   onGetText: (double value) {
                //     return Text('${value.toInt()}%');
                //   },
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue[100]),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: [
                Text('units amount:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[100]),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 60),
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [Center(child: Text('Notifications:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),))],
              )),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Signed in as:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              user.email!,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(),
          menuItem(1, "Profile", Icons.person,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(2, "Settings", Icons.settings,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(3, "Logout", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.profile;
            } else if (id == 2) {
              currentPage = DrawerSections.settings;
            } else if (id == 3) {
              FirebaseAuth.instance.signOut();
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(flex: 3, child: Text(title)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    totalStream.cancel();
    super.deactivate();
  }
}

enum DrawerSections {
  settings,
  profile,
  logout,
}
