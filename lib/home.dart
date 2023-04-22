import 'package:electrifyy/database.dart';
import 'package:electrifyy/profile.dart';
import 'package:electrifyy/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'header_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(id: '', pnum: '');
}

class _HomePageState extends State<HomePage> {
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    isMounted = true;
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  var currentPage = DrawerSections.profile;
  final user = FirebaseAuth.instance.currentUser!;
  String name = '';
  String id = '';
  String pnum = '';

  _HomePageState({required this.id, required this.pnum});

  String get getId => id;
  String get getPnum => pnum;

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService(uid: user.uid);
    Future getData() async {
      dynamic names = await databaseService.getCurrentUserData();
      if (names != null) {
        if (isMounted) {
          setState(() {
            name = names[0];
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue[100]),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            margin: EdgeInsets.only(right: 40, left: 40),
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
                        Text("Welcome  $name !",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10),
                        Text("Consumer ID : $id",
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[100]),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            margin: EdgeInsets.only(right: 40, left: 40),
            child: Row(
              children: [
                Text('Live Consumption',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                ) ),
                SizedBox(
                  width: 20.0,
                ),
                SimpleCircularProgressBar(
                  mergeMode: true,
                  onGetText: (double value) {
                    return Text('${value.toInt()}%');
                  },
                ),
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
            margin: EdgeInsets.only(right: 40, left: 40),
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
              margin: EdgeInsets.only(right: 40, left: 40),
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
              user!.email!, // Replace with actual user name
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
}

enum DrawerSections {
  settings,
  profile,
  logout,
}
