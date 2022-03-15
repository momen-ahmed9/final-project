import 'package:bakery/main.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/home/home map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


List<Workers> allWorkers=[];
class Workers{
  String? iD;
  String? name;
  Workers({
    this.iD, this.name
  });
  factory Workers.fromJson(Map<dynamic, dynamic>json){
    return Workers(iD: json['ID'],name:json['name']);
  }
  static Future getAllWorkers() async{
    var query= await workers.doc(FirebaseAuth.instance.currentUser!.uid).collection('allWorkers').get();
    List r=query.docs.map((e) => e.data()).toList();
    if (allWorkers.isNotEmpty){
      allWorkers.clear();
    }
    r.forEach((doc){
      Workers d= Workers.fromJson(doc);
      allWorkers.add(d);
    });
   }
  
  List <Workers> getWorkersList(){
    return allWorkers;
  }
}
List<Accomplished> allAccomplished=[];
class Accomplished{
  String? iD;
  String? name;
  int? role;
  int? accomplished;
  double? payment;
  bool?cleanedTrays;
  bool?cleanedGeneral;
  Accomplished({
    this.iD, this.name,this.role,this.accomplished,this.payment,this.cleanedGeneral,this.cleanedTrays
  });
  factory Accomplished.fromJson(Map<dynamic, dynamic>json){
    return Accomplished(iD: json['ID'],name:json['name'],role:json['role'],accomplished:json['accomplished'],payment:json['payment'],cleanedTrays:json['cleanedTrays'],cleanedGeneral:json['cleanedGeneral']);
  }
  static Future getAllAccomplished(String id) async{
    var query= await accomplishedCollection.doc(id).collection('accomplishes').get();
    List r=query.docs.map((e) => e.data()).toList();
    if (allAccomplished.isNotEmpty){
      allAccomplished.clear();
    }
    r.forEach((doc){
      Accomplished d= Accomplished.fromJson(doc);
      allAccomplished.add(d);
    });
   }
  
  List <Accomplished> getAccomplishedList(){
    return allAccomplished;
  }
}

List<DeliveryDB> delOrders =[];
class DeliveryDB{
GeoPoint? userLoc;
GeoPoint? bakeryLoc;                               
String? userId;                           
String? bakeryId;                             
double? quantity;                            
double? price;                              
Timestamp? time;                            
double? cost; 
double? delCost;
 DeliveryDB({
    this.userLoc, this.userId,this.bakeryLoc,this.bakeryId,this.quantity,this.price,this.time,this.cost,this.delCost
  });
  factory DeliveryDB.fromJson(Map<dynamic, dynamic>json){
    return DeliveryDB(userId: json['userId'],userLoc:json['userLoc'],bakeryId: json['bakeryId'],price: json['price'],bakeryLoc: json['bakeryLoc'],quantity:json['quantity'] ,cost:json['cost'] ,delCost:json['delCost'],time: json['time'] );
  }
  List <DeliveryDB> getOrders(Timestamp t){
    Future getOrdersFromFirestore() async {
    var query = await orders.where('time',isGreaterThan: t).where('stat',isEqualTo: false).get();

    List results = query.docs.map((e) => e.data()).toList();

    if (delOrders.isNotEmpty) {
      delOrders.clear();
    }
    results.forEach((element) {
      DeliveryDB r = DeliveryDB.fromJson(element);
      delOrders.add(r);
    });
  }
    return delOrders;
  }
}

List <HomeMarkers> bakeries=[];
class HomeMarkers{
  String? iD;
  String? name;
  int? available;
  double? price;
  GeoPoint? location;
  HomeMarkers({
   this.iD,this.name,this.available,this.price,this.location,
  });
  factory HomeMarkers.fromJson(Map<dynamic, dynamic>json){
    return HomeMarkers(iD: json['ID'],name:json['name'],available: json['available'],price: json['price'],location: json['location']);
  }
    
  List <HomeMarkers> getBakeries(){
    Future getBakeriesFromFirestore() async {
    var query = (await products.get());

    List results = query.docs.map((e) => e.data()).toList();

    if (bakeries.isNotEmpty) {
      bakeries.clear();
    }
    results.forEach((element) {
      HomeMarkers r = HomeMarkers.fromJson(element);
      bakeries.add(r);
    });
  }
    return bakeries;
  }

}