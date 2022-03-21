
import 'dart:async';


import 'package:bakery/home/home%20map.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/main.dart';
import 'package:bakery/variables/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//bool dPaid=false;
//bool acceptD=false;

class Delivery extends StatefulWidget {
  const Delivery({ Key? key }) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  var timeOfActive;
  static bool activityStatus=false;
  //static bool facilityStatus=false;
  static bool foot=true, bike=false, motor=false, tuk=false;
  double facility=1,quantity=100;
  double range=1000;
  var pin;
  @override
  void initState() {
    // TODO: implement initState
    getCurrLoc();
    timeOfActive=Timestamp.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.05),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(' facility',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:EdgeInsets.all(7),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  ),
                  child:Column(
                    children:[ Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: ChoiceChip(label: Text('on foot',style: TextStyle(fontSize: 35,color: Colors.black)),
                        selected: foot,
                        backgroundColor: Colors.red[50],
                        selectedColor: Colors.red[200],
                        onSelected: (value){
                    
                          setState(() {
                            foot=value;
                            bike=false;
                            motor=false;
                            tuk=false;
                            facility=1;
                          });
                        },
                        avatar: CircleAvatar(child: Icon(Icons.nordic_walking,color: Colors.white,size: 35),backgroundColor: Colors.red)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: ChoiceChip(label: Text('bicycle',style: TextStyle(fontSize: 35,color: Colors.black),),
                        selected: bike,
                        backgroundColor: Colors.red[50],
                        selectedColor: Colors.red[200],
                        onSelected: (value){
                          setState(() {
                            foot=false;
                            bike=value;
                            motor=false;
                            tuk=false;
                            facility=2;
                          });
                        },
                        avatar: CircleAvatar(child: Icon(Icons.bike_scooter_sharp,color: Colors.white,size: 30),backgroundColor: Colors.red)
                        ),
                      )]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: ChoiceChip(label: Text('motor  ',style: TextStyle(fontSize: 35,color: Colors.black)),
                        selected: motor,
                        backgroundColor: Colors.red[50],
                        selectedColor: Colors.red[200],
                        onSelected: (value){
                          setState(() {
                            foot=false;
                            bike=false;
                            motor=value;
                            tuk=false;
                            facility=3;
                          });
                        },
                        avatar: CircleAvatar(child: Icon(Icons.delivery_dining_outlined,color: Colors.white,size: 35,),backgroundColor: Colors.red)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: ChoiceChip(label: Text('tuk tuk',style: TextStyle(fontSize: 35,color: Colors.black)),
                        selected: tuk,
                        backgroundColor: Colors.red[50],
                        selectedColor: Colors.red[200],
                        onSelected: (value){
                          setState(() {
                            foot=false;
                            bike=false;
                            motor=false;
                            tuk=value;
                            facility=4;
                          });
                        },
                        avatar: CircleAvatar(child:  Image(image: AssetImage('assets/images/tuktuk.png'),color: Colors.white,width: 35,),backgroundColor:Colors.red ,)
                        ),
                      )
                        ]
                    )
                    ]
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(' status',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),
               Padding(
                padding:EdgeInsets.all(7),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text('activity status :',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Row(
                          children: [
                            FloatingActionButton(
                              heroTag: null,
                              onPressed: (){
                                if (!activityStatus)
                                {
                                  timeOfActive=Timestamp.fromDate(DateTime.now());
                                  if (facility==1){range=1000;quantity=100;}
                                  else if (facility==2){range=2000;quantity=100;}
                                  else if (facility==3){range=4000;quantity=100;}
                                  else if (facility==4){range=6000;quantity=1500;}
                                  setState(() {
                                    activityStatus=true;
                                  });
                                }
                                else
                                {
                                  range=1000;
                                  quantity=100;
                                  setState(() {
                                    activityStatus=false;
                                    facility=1;
                                  });
                                }
                              },
                              mini: true,
                              child: activityStatus?Text('ON'):Text('OFF'),
                              backgroundColor: activityStatus?Colors.green:Colors.grey
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
               ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(' orders',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding:EdgeInsets.all(7),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child:StreamBuilder(stream:orders.where('time',isGreaterThan: timeOfActive!).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!activityStatus) {return Align(alignment: Alignment.center, child: Text('OFFLINE !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.grey)));}
                      else if(!snapshot.hasData&&activityStatus){return Align(alignment: Alignment.center, child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text('No orders yet !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ));}
                      else
                      {
                      var snapshots=snapshot.requireData;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshots.size,
                        itemBuilder:(context,index){
                          if (snapshots.docs[index]['distance']>range||snapshots.docs[index]['quantity']>quantity||snapshots.docs[index]['accept']==true){return Container();}
                          else {
                          return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: FloatingActionButton(heroTag: null,
                                    onPressed: (){
                                      Completer<GoogleMapController> _controller=Completer();
                                      Set<Marker> markers=Set<Marker>();
                                      markers.clear();
                                      GeoPoint x=snapshots.docs[index]['bakeryLoc'];
                                      GeoPoint y=snapshots.docs[index]['userLoc'];
                                      markers.add(Marker(markerId: MarkerId('bakery'),
                                        position: LatLng(x.latitude,x.longitude),
                                        icon: BitmapDescriptor.defaultMarker
                                        )
                                      );
                                      markers.add(Marker(markerId: MarkerId('customer'),
                                        position: LatLng(y.latitude,y.longitude),
                                        icon: BitmapDescriptor.defaultMarker
                                        )
                                      );
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMap(
                                        initialCameraPosition:CameraPosition(target: LatLng(pin.latitude, pin.longitude),
                                          zoom: 14,
                                          tilt: 30,
                                          bearing: 90),
                                        myLocationEnabled: true,
                                        compassEnabled: false,
                                        tiltGesturesEnabled: false,
                                        mapType: MapType.normal,
                                        markers:markers,
                                        onMapCreated: (GoogleMapController controller) {
                                          _controller.complete(controller);
                                        },
                                      )));
                                    },
                                    child: Icon(Icons.pin_drop),
                                    backgroundColor: Colors.red,
                                    mini: true,
                                  ),
                                ),
                                ChoiceChip(label: Row(
                                  children: [
                                    Text('${snapshots.docs[index]['quantity']}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800)),
                                    Text('${snapshots.docs[index]['cost']} (SDG)',style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic))
                                  ],
                                ),
                                selected: false,
                                avatar: CircleAvatar(child: Icon(Icons.bakery_dining_outlined))
                                ),
                                Padding(padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Text('${snapshots.docs[index]['delCost']} ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800)),
                                    Text(' SDG',style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic))
                                  ],
                                ),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: FloatingActionButton(heroTag: null,onPressed: (){
                                    orders.doc(snapshots.docs[index].id).set({
                                      'accept':true
                                    },
                                      SetOptions(merge: true)
                                    );
                                    delMarker.clear();
                                    setState(() {
                                      activityStatus=false;
                                      delUserIdCard=snapshots.docs[index]['userId'];
                                      delBakeryNameCard=snapshots.docs[index]['bakeryName'];
                                      delQuantityCard=snapshots.docs[index]['quantity'];
                                      delPriceCard=snapshots.docs[index]['price'];
                                      delCostCard=snapshots.docs[index]['delCost'];
                                      GeoPoint x=snapshots.docs[index]['bakeryLoc'];
                                      GeoPoint y=snapshots.docs[index]['userLoc'];
                                      delMarker.add(Marker(markerId: MarkerId('bakery'),
                                        position: LatLng(x.latitude,x.longitude),
                                        icon: bakeryIcon!
                                        )
                                      );
                                      delMarker.add(Marker(markerId: MarkerId('customer'),
                                        position: LatLng(y.latitude,y.longitude),
                                        icon: userIcon!
                                        )
                                      );
                                      delCard=vis;
                                    });
                                  },
                                    child: Icon(Icons.check_outlined),
                                    backgroundColor: Colors.red,
                                    mini: true,
                                  ),
                                )
                              ],
                            ),
                          );}
                        }
                      );}
                    } ,),
                )
              ),
            ],
          ),
        )
      ),
    );
  }
  getCurrLoc() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      pin=GeoPoint(position.latitude, position.longitude);
    });
  }
}