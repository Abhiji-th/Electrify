import 'package:electrifyy/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'header_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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

  var currentPage=DrawerSections.profile;
  final user = FirebaseAuth.instance.currentUser!;
  String name='';
  String id ='';
  String pnum ='';

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService(uid: user.uid);
    Future getData() async {
      dynamic names = await databaseService.getCurrentUserData();
      if(names!=null){
        if(isMounted){
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
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Center(
            child: Text('HOME', style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.lightBlue[200],),
      body: ListView(
        children: [
          SizedBox(height: 30.0,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey
            ),
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            margin: EdgeInsets.only(right: 40, left: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   margin: EdgeInsets.all(10.0),
                //   child: CircleAvatar(
                //     child: Image.asset('assets/man.gif'),
                //   ),
                // ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text("Welcome $name!"),
                        SizedBox(height:10),
                        Text("Consumer ID : $id"),
                        SizedBox(height:10),
                        Text("Phone Number : $pnum")
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey
            ),
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            margin: EdgeInsets.only(right: 40, left: 40),
            child: Row(
              children: [Text('Live Consumption'),
                SizedBox(width: 20.0,),
                SimpleCircularProgressBar(
                  mergeMode: true,
                  onGetText: (double value) {
                    return Text('${value.toInt()}%');
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black26
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            margin: EdgeInsets.only(right: 40, left: 40),
            child: Row(
              children: [
                Text('units amount:'),
              ],
            ),
          ),
          SizedBox(height: 30.0,),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 60),
              margin: EdgeInsets.only(right: 40, left: 40),
              child: Row(
                children: [
                  Center(child: Text('Notifications'))
                ],
              )
          ),
          // Padding(
          //   padding: const EdgeInsets.all(35.0),
          //   child: SizedBox(
          //     height: 52,
          //     width: 200,
          //     child: ElevatedButton(
          //       onPressed: () {},
          //       child: Text('Refresh',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20,
          //         ),),
          //
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.blue,
          //       ),
          //     ),
          //   ),
          // ),
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
    Widget MyDrawerList(){
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1,"Profile",Icons.person,currentPage==DrawerSections.profile ? true:false
          ),
          menuItem(2,"Settings",Icons.settings,currentPage==DrawerSections.settings ? true:false
          ),
          menuItem(3,"Logout",Icons.logout,currentPage==DrawerSections.logout ? true:false
          ),
        ],
      ),
    );
    }
    Widget menuItem(int id,String title,IconData icon,bool selected){
    return Material(
      color: selected ?Colors.grey[300]:Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
              setState(() {
                if(id==1){
                  currentPage=DrawerSections.profile;
                }
                else if(id==2){
                  currentPage=DrawerSections.settings;
                }
                else if(id==3){
                  FirebaseAuth.instance.signOut();
                  currentPage=DrawerSections.logout;
                }
              });
        },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Icon(icon,
              size: 20,
              color: Colors.black
                ,),
            ),
            Expanded(
                flex: 3,
                child: Text(title)),
          ],
        ),
      ),
      ),
    );
    }

  }
  enum DrawerSections{
  settings,
    profile,
    logout,
  }
