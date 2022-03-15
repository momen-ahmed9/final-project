
import 'dart:async';

import 'package:bakery/database/database.dart';
import 'package:bakery/home/home%20map.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/functions.dart';
import 'package:bakery/variables/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'login/login.dart';
import 'manager/manager.dart';
import 'home/home.dart';
import 'worker/workers.dart';
import 'delivery/delivery.dart';
import 'package:bakery/worker/workers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Set<Marker> delMarker=Set<Marker>();
GeoPoint l=GeoPoint(0, 0);

String orderDocId='';

Color? workerColor=Colors.grey[600];

FlutterLocalNotificationsPlugin notification= FlutterLocalNotificationsPlugin();

bool accept=false;
bool paid=false;
bool here=false;
bool haveBakery=false;

String delBakeryNameCard='';
String delBakeryIdCard='';
double delCostCard=0;
double delQuantityCard=0;
double delPriceCard=0;
double delCard=invis;

String orderBakeryIdCard='';
String orderBakeryNameCard='';
double orderCostCard=0;
double orderQuantityCard=0;
double orderPriceCard=0;
double orderCard=invis;

var name;
Future getName()async{
  await users.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => {name=value['userName']});
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:FirebaseAuth.instance.currentUser==null? Login():MyApp(),debugShowCheckedModeBanner:false));
  }
class MyApp  extends StatefulWidget {

  @override
  _MyApp createState() => _MyApp();
}
class _MyApp extends State<MyApp> {

  Future getAccept() async{
  await orders.where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .where('bakeryId',isEqualTo:orderBakeryIdCard)
  .where('stat',isEqualTo: false).get()
  .then((value) => {accept=value.docs[0]['accept'],here=value.docs[0]['here']});
}



  int _currentIndex=0;


  List<Widget> _options=<Widget>[
    Home(),
    Manager(),
    Worker(),
    Delivery()
  ];
  void _onItemTap(int index){
    setState(() {
      _currentIndex=index;
      if (index==2){workerColor=Colors.red;}
      else{workerColor=Colors.grey[600];}
    });
  }
  void setSourceIcon() async {
    bakeryIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/bakeryPin.png',
    );
    userIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/userPin.png'
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrLoc();
    setSourceIcon();
    //getName();
  }
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller=Completer();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Column(                      
                        children:[
                          Icon(Icons.person_pin ,size: 90),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Container(
                              child: FutureBuilder(
                                future: getName(),
                                builder: (context,snapshot){
                                  return Text('${name!}',style: TextStyle(fontSize: 20),);
                                }
                              )
                            ),
                          )
                        ]
                      ),
                    ),
                    //FloatingActionButton(
                      //heroTag: null, 
                      //onPressed: (){
                        //notification.show(0,'DELIVERY','Your order was accepted!',NotificationDetails(android: AndroidNotificationDetails('','',importance: Importance.max)));
                      
                      //onPressed: ()async{await FirebaseAuth.instance.signOut();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                      //},
                      //child: Text('Logout'),
                    //)
                  ],
                ),
              ),
      appBar: AppBar(title: Text("bakery"),
      centerTitle: true,
      backgroundColor: Colors.red),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 35,),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts,size: 35),
            label: 'manager',
            
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('assets/images/worker.png'),height: 35,width: 35,color: workerColor,),
            label: 'worker'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining_outlined,size: 35),
            label: 'delivery'
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTap
      ),
      body: Container(
        child:
          
          SafeArea(child:Stack(
            children: [
              _options.elementAt(_currentIndex),
              AnimatedPositioned(child: Container(
             padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.9),
                  ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red.withOpacity(0.5),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            //Icon(Icons.person_pin ,size: 40),
                            Image(image: AssetImage('assets/images/order.png'),height: 40,),
                            Text(orderBakeryNameCard,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900))
                          ],
                        ),
                        Text('${orderQuantityCard.truncate()}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900))
                      ],
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Order Price : '+'${orderPriceCard}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Delivery Cost : '+'${orderCostCard}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
                ),
                Padding(padding:EdgeInsets.all(10),
                child:accept? Text('Accepted',style: TextStyle(fontSize: 20,color: Colors.green[800],fontWeight: FontWeight.w900)):CircularProgressIndicator() 
                ),
                Divider(),
                FutureBuilder(
                  future: getAccept(),
                  builder: (context,snapshot){
                    if (!accept&&!here){ return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                      heroTag: null,
                      onPressed: (){
                        orders.where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .where('bakeryId',isEqualTo:orderBakeryIdCard)
                        .where('accept',isEqualTo: false)
                        .where('stat',isEqualTo: false).get()
                        .then((value) => {orderDocId=value.docs[0].id});
                        orders.doc(orderDocId).delete();
                        setState(() {
                          orderBakeryNameCard='';
                          orderQuantityCard=0;
                          orderPriceCard=0;
                          orderCostCard=0;
                          orderCard=invis;
                        });
                      },
                      child: Text('Cancel'),
                      backgroundColor:Colors.red.withOpacity(0.5) ,
                      ),
                    );}
                    if(!here&&accept){ 
                      notification.show
                      (
                        0,
                        'DELIVERY',
                        'Your order was accepted!',
                        NotificationDetails
                          (
                            android: AndroidNotificationDetails('' , '' , importance: Importance.max)
                          )
                      );
                      return Column(
                      children: [
                        Align(alignment: Alignment.center, child: Text('ON THE WAY...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900))),
                        LinearProgressIndicator(),
                      ],
                    );}
                    else{
                      notification.show(0,'DELIVERY','Your order is here!',NotificationDetails(android: AndroidNotificationDetails('','',importance: Importance.max)));
                    return FloatingActionButton(
                      heroTag: null,
                      onPressed: (){
                      orders.where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where('bakeryId',isEqualTo:orderBakeryIdCard)
                      .where('accept',isEqualTo: true)
                      .where('stat',isEqualTo: false).get()
                      .then((value) => {orderDocId=value.docs[0].id});
                      orders.doc(orderDocId).set({
                      'paid':true,
                      'stat':true
                      },
                        SetOptions(merge: true)
                      );
                      setState(() {
                        orderBakeryNameCard='';
                        orderQuantityCard=0;
                        orderPriceCard=0;
                        orderCostCard=0;
                        accept=false;
                        here=false;
                        orderCard=invis;
                      });
                    },
                      child: Text('Paid'),
                      backgroundColor:Colors.red.withOpacity(0.5) ,
                    );}
                  }
                )
              ],
            ),
          ), 
            duration: Duration(milliseconds: 500),
            left: 1,
            right: 1,
            top:orderCard,
            curve: Curves.easeInOut,
          ),
          AnimatedPositioned(child: Container(
             padding: EdgeInsets.all(5),
             margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.9),
                  ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red.withOpacity(0.5),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.delivery_dining,size: 45),
                            Text(delBakeryNameCard,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900))
                          ],
                        ),
                        Text('${delQuantityCard.truncate()}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900))
                      ],
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Order Price : '+'${delPriceCard}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Delivery Cost : '+'${delCostCard}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
                ),
                const Divider(),
                FutureBuilder(
                  future: getAccept(),
                  builder: (context,snapshot){
                     return Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            heroTag: null,
                            onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Positioned.fill(
                              child: GoogleMap(initialCameraPosition:CameraPosition(target: LatLng(l.latitude, l.longitude),
                                zoom: 14,
                                tilt: 30,
                                bearing: 90
                              ),
                              myLocationEnabled: true,
                              compassEnabled: false,
                              tiltGesturesEnabled: false,
                              mapType: MapType.normal,
                              markers:delMarker,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                            )));
                          },
                          child: const Icon(Icons.pin_drop),
                          backgroundColor:Colors.red.withOpacity(0.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:here?FutureBuilder(future: getAccept(),
                          builder:(context,snapshot){
                            if (!paid){return CircularProgressIndicator(strokeWidth: 4,valueColor: AlwaysStoppedAnimation<Color> (Colors.white));}
                            else {
                              return FloatingActionButton(
                              heroTag: null,
                              child: Text('Done'),
                              onPressed:(){
                              setState(() {
                                delBakeryNameCard='';
                                delQuantityCard=0;
                                delPriceCard=0;
                                delCostCard=0;
                                paid=false;
                                here=false;
                                delCard=invis;
                                delMarker.clear();
                              });
                            });
                            }
                          } ,
                          )
                          :FloatingActionButton(
                            heroTag: null,
                            onPressed:(){
                            setState(() {
                              here=true;
                            });
                          },
                          child: Text('HERE!'),
                          backgroundColor:Colors.red.withOpacity(0.5)
                          ),
                        )
                      ]);
                    }
                ),
              ],
            ),
          ), 
            duration: const Duration(milliseconds: 500),
            left: 1,
            right: 1,
            top:delCard,
            curve: Curves.easeInOut,
          ),
          
            ],
          )  
        
      )
    ));
  }
  void getCurrLoc() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      l=GeoPoint(position.latitude, position.longitude);
    });
  }
}




