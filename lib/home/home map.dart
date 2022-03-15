import 'dart:async';
import 'package:bakery/database/database.dart';
import 'package:bakery/main.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:bakery/variables/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
const double vis=15;
const double invis=-400;

double dist=0;


class HomeMap extends StatefulWidget {
  const HomeMap({ Key? key }) : super(key: key);
  

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  List allBakeries=[];
  GeoPoint location=GeoPoint(0, 0);
  String name='';
  String id='';
  double available=0;
  double price=0;
  double quantity=0;
  double cost=0;
  double delCost=0;
  double card=invis;
  Set<Marker> marker=Set<Marker>();
  final orderMaFormKey = GlobalKey<FormState>();
    @override
  void initState() {
    super.initState();
    showBakeriesOnMap();
  }
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller=Completer();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(15.5897999, 32.5357641),
                zoom: 14,
                tilt: 45,
                bearing: 90
              ),
              myLocationEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              mapType: MapType.normal,
              markers: marker,
              onTap: (LatLng loc){
                setState(() {
                  card=invis;
                });
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              ),
            ),
            AnimatedPositioned(
              duration:Duration(milliseconds: 500),
              left: 1,
              right: 1,
              bottom: card,
              curve: Curves.easeInOut,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Form(
                  key: orderMaFormKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('${name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('${price}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)),
                          ),
                          
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.all(10),
                          child: Text('available : ${available}',style: TextStyle(fontSize: 20)),
                          ),
                          Padding(padding: EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.all(10),
                              child: Container(
                                height: 30,
                                width: 70,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter the quantity of order";
                                    }
                                  },
                                  controller: orderQtM,
                                  keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder()
                                    ),
                                ),
                              )
                              ),
                              Padding(padding: EdgeInsets.all(15),
                              child: FloatingActionButton(heroTag: null,onPressed: (){
                                if (orderMaFormKey.currentState!.validate())
                                {
                                GeoPoint loc=GeoPoint(0,0);
                                getCurrLoc() async {
                                  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                  loc =GeoPoint(position.latitude, position.longitude);
                                }
                                cost=double.parse(orderQtM.text)*price;
                                dist=getDist(loc,location);
                                double delCost=dist*0.5;
                                orders.add({
                                  'userLoc':loc,
                                  'bakeryLoc':location,
                                  'userId':FirebaseAuth.instance.currentUser!.uid,
                                  'bakeryId':id,
                                  'bakeryName':name,
                                  'quantity':double.parse(orderQtM.text),
                                  'price':price,
                                  'time':Timestamp.fromDate(DateTime.now()),
                                  'cost':cost,
                                  'stat':false,
                                  'delCost':delCost,
                                  'accept':false,
                                  'here':false,
                                  'paid':false,
                                  'distance':dist
                                });
                                dist=0;
                                setState(() {
                                  final snackBar=SnackBar(content:Text('Order created'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                });
                              }},
                              mini: true,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.add),
                              ),
                              )
                            ],
                          ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),  
            ),
        ],
      ),
    );
  }
  showBakeriesOnMap(){
    setState(() {
      allBakeries.forEach((element) {
        location=element.location;
        LatLng pin=new LatLng(location.latitude, location.longitude);
        marker.add(Marker(markerId: MarkerId(name),
        position: pin,
        icon: bakeryIcon!,
        onTap: () {
          setState(() {
            location=element.location;
            name=element.name;
            available=element.available;
            price=element.price;
            id=element.iD;
            this.card=vis;
          });
        },
        ));
      });
    });
  }
 getDist(GeoPoint x, GeoPoint y){
    var z= Geolocator.distanceBetween(x.latitude, x.longitude, y.latitude, y.longitude);
    return z;
  }
}