import 'package:bakery/database/database.dart';
import 'package:bakery/manager/bakery.dart';
import 'package:bakery/manager/settings.dart';
import 'package:bakery/manager/storage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Color? storageColor=Colors.grey[600];
class Manager extends StatefulWidget {
  const Manager({ Key? key }) : super(key: key);

  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  
  int _currentIndex=0;
  List<Widget> _options=<Widget>[
    Settings(),
    Bakery(),
    Storage(),
  ];
  void _onItemTap(int index){
    setState(() {
      _currentIndex=index;
      if (index==2){storageColor=Colors.red;}
      else{storageColor=Colors.grey[600];}
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.red,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,size: 30,),
            label: 'system settings',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined,size: 30),
            label: 'bakery'
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('assets/images/storage.png'),height: 30,width: 30,color: storageColor,),
            label: 'storage'
          ),

        ],
        currentIndex: _currentIndex,
        onTap: _onItemTap
      ),
      body: SafeArea(child: _options.elementAt(_currentIndex))
    );
  }
}