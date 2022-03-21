import 'dart:async';
import 'package:bakery/database/database.dart';
import 'package:bakery/main.dart';
import 'package:bakery/manager/manager.dart';
import 'package:bakery/manager/settings.dart';
import 'package:bakery/variables/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

  LatLng pinn=LatLng(15.5477976, 32.5545914);
  Set<Marker> x=Set<Marker>();

class SettingnsMap extends StatefulWidget {
  const SettingnsMap({ Key? key }) : super(key: key);

  @override
  _SettingnsMapState createState() => _SettingnsMapState();
}

class _SettingnsMapState extends State<SettingnsMap> {


  @override
  void initState() {
    getCurrLoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller=Completer();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: GoogleMap(initialCameraPosition:CameraPosition(target: pinn,
            zoom: 14,
            tilt: 30,
            bearing: 90
          ),
          myLocationEnabled: true,
          compassEnabled: false,
          tiltGesturesEnabled: false,
          mapType: MapType.normal,
          markers:x,
          onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
          },
          onCameraMove: (CameraPosition cp){
            LatLng y=cp.target;
            setState(() {
              pinn=LatLng(y.latitude, y.longitude);
            });
          },
          ),
          ),
          Align(alignment: Alignment.center,
          child: Icon(Icons.pin_drop,color: Colors.black,),
          ),
          Positioned(child: FloatingActionButton(heroTag: null,onPressed: (){
            locationOfBakery=pinn;
            setState(() {
              locationValidation=true;
              
            });
            Navigator.pop(context);
          },
          child: Text('Set'),
          backgroundColor: Colors.red,),
          bottom: 50,
          left: 50,
          right: 50,
          )
        ],
      ),
    );
  }
    void getCurrLoc() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      pinn=LatLng(position.latitude, position.longitude);
    });
  }
}