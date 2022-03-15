import 'dart:async';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home map.dart';
class Lists extends StatefulWidget {
  const Lists({ Key? key }) : super(key: key);

  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  double available=0;
  double price=0;
  double quantity=0;
  double cost=0;
  double delCost=0;
  double dist=0;
  final orderLiFormKey = GlobalKey<FormState>();
  String searchKey = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,size: 30,
                  ),
                  hintText: 'Search for a bakery',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                )
              ),
              StreamBuilder(
                stream:(searchKey == ''|| searchKey.trim() == '')
                ? products.snapshots()
                : products.where('SearchIndex', arrayContains: searchKey).snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot==null){return CircularProgressIndicator();}
                else{
                var snapshots=snapshot.requireData;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.size,
                  itemBuilder: (context,index){
                  return Padding(
                    padding:EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                      child: Form(
                        key: orderLiFormKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.3),
                                    ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:EdgeInsets.all(10),
                                    child: Text(snapshots.docs[index]['bakeryName'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)),
                                  ),
                                  Padding(
                                    padding:EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text('${snapshots.docs[index]['price']} SDG',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)),
                                        ),
                                        FloatingActionButton(heroTag: null,onPressed: (){
                                          Completer<GoogleMapController> _controller=Completer();
                                          Set<Marker> markers=Set<Marker>();
                                          markers.clear();
                                          GeoPoint x=snapshots.docs[index]['Location'];
                                          markers.add(Marker(markerId: MarkerId('bakery'),
                                            position: LatLng(x.latitude,x.longitude),
                                            icon: BitmapDescriptor.defaultMarker
                                            )
                                          );
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMap(
                                            initialCameraPosition:CameraPosition(target: LatLng(x.latitude, x.longitude),
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
                                        backgroundColor: Colors.red.withOpacity(0.5)
                                      )
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                            Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,right: 5,bottom: 5),
                                      child: Text('Avilable Quantity: ',style: TextStyle(fontSize: 25)),
                                    ),
                                    Padding(padding: EdgeInsets.all(10),
                                    child:Text('${snapshots.docs[index]['available']} ',style: TextStyle(fontSize: 30)) ,
                                    )
                                  ],
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        height: 50,
                                        width: 70,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter";
                                            }
                                          },
                                          controller: orderQtL,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder()
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                    children:[ 
                                      Text('${cost} + ${delCost} ',style: TextStyle(fontSize: 25)),
                                      Text('(SDG)',style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900)),
                                    ]
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: FloatingActionButton(heroTag: null, onPressed: (){
                                        if (orderLiFormKey.currentState!.validate())
                                        {
                                        GeoPoint locOfBakery=snapshots.docs[index]['location'];
                                        GeoPoint locOfUser=GeoPoint(0,0);
                                        getCurrLoc() async {
                                          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                          locOfUser =GeoPoint(position.latitude, position.longitude);
                                        }
                                        dist=getDist(locOfBakery,locOfUser);
                                        setState(() {
                                          delCost=dist*0.5;
                                          cost=double.parse(orderQtL.text)*price;
                                        });
                                        orders.add({
                                          'userLoc':locOfUser,
                                          'bakeryLoc':locOfBakery,
                                          'userId':FirebaseAuth.instance.currentUser!.uid,//
                                          'bakeryName':snapshots.docs[index]['bakeryName'],
                                          'bakeryId':snapshots.docs[index]['ID'],//
                                          'quantity':double.parse(orderQtL.text),//
                                          'price':snapshots.docs[index]['price'],//
                                          'time':Timestamp.fromDate(DateTime.now()),
                                          'cost':cost,//
                                          'stat':false,//
                                          'delCost':delCost,
                                          'accept':false,
                                          'here':false,
                                          'paid':false,
                                          'distance':dist
                                        });
                                        dist=0;
                                      }},
                                      child: Icon(Icons.add),
                                      mini: true,
                                      backgroundColor: Colors.red
                                      ),
                                    )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
              }},
              ),
            ],
          ),
        ),
      ),
    );
  }
  getDist(GeoPoint x, GeoPoint y)async{
    var z=await Geolocator.distanceBetween(x.latitude, x.longitude, y.latitude, y.longitude);
    return z;
  }
}