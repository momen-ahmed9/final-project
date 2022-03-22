import 'package:bakery/database/database.dart';
import 'package:bakery/home/home%20map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bakery/home/lists.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    HomeMarkers.setBakeries();
    return Scaffold(backgroundColor: Colors.red.withOpacity(0.05),
      body: 
    SafeArea(child: 
       Stack(
        children: [
          Positioned(
            left: 50,
            right: 50,
            top: 100,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Lists()));
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 250,
                      color: Colors.red[200],
                      child: Image(image: AssetImage('assets/images/list.png'),
                      width: 250,
                      height: 100,)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('view by list',
                      style:TextStyle(fontSize: 25,fontWeight:FontWeight.w900)),
                    )
                  ],
                ),
                width: 250,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red.withOpacity(0.1),
                ),
                
              ),
              
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            bottom: 100,
            child: InkWell(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeMap()));},
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 250,
                      color:  Colors.red[200],
                      child: Image(image: AssetImage('assets/images/map.png'),
                      width: 250,
                      height: 100,)
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('view by map',
                       style:TextStyle(fontSize: 25,fontWeight:FontWeight.w900, color: Colors.black)),
                    )
                  ],
                ),
                width: 250,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red.withOpacity(0.1),
                ),
              ),
            ),
          )
        ],
      ),
    )
    );
  }
}