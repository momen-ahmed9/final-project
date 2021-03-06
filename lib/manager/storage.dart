import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Storage extends StatefulWidget {
  const Storage({ Key? key }) : super(key: key);

  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  static bool edit=false;
  static num? oilStorage,yeastStorage,enhancerStorage,saltStorage;
  Future getStorage()async{
    await storage.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => {oilStorage=value['oil'],yeastStorage=value['yeast'],enhancerStorage=value['enhancer'],saltStorage=value['salt']});
  }
  @override
  void initState() {
    //getStorage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.red.withOpacity(0.05),
      body: SafeArea(
      child: FutureBuilder(
        future: getStorage(),
        builder: (context,snapshot) {
          if (oilStorage==null||yeastStorage==null||enhancerStorage==null||saltStorage==null)
          {return CircularProgressIndicator();}
          return Stack(
            children:[ GridView.count(crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.all(5),
            children: [
              Container(
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                child: Padding(
                          padding:EdgeInsets.all(3),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Yeast',style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                                Divider(),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${yeastStorage!.truncate()}',style: TextStyle(fontSize: 30)),
                                        Text('pack',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${(yeastStorage!/20).round()}',style: TextStyle(fontSize: 30)),
                                        Text('box',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                    edit?Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Container(
                                      height: 25,
                                      width: 90,
                                      child: TextFormField(
                                        controller: yeastToAdd,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      ),
                                    ),
                                    ):Container()
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
              ),
              Container(
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ), 
                child: Padding(
                          padding:EdgeInsets.all(3),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Enhancer',style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                                Divider(),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${enhancerStorage!.truncate()}',style: TextStyle(fontSize: 30)),
                                        Text('envelope',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${(enhancerStorage!/100).round()}',style: TextStyle(fontSize: 30)),
                                        Text('box',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                    edit? Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Container(
                                      height: 25,
                                      width: 90,
                                      child: TextFormField(
                                        controller: enhancerToAdd,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      ),
                                    ),
                                    ):Container()
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
              ),
              Container(
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ), 
                child: Padding(
                          padding:EdgeInsets.all(7),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Salt',style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                                Divider(),
                                Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${saltStorage!.truncate()}',style: TextStyle(fontSize: 40)),
                                        Text('sack',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                    edit?Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Container(
                                      height: 25,
                                      width: 90,
                                      child: TextFormField(
                                        controller: saltToAdd,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      ),
                                    ),
                                    ):Container()
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
              ),
              Container(
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ), 
                child: Padding(
                          padding:EdgeInsets.all(7),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 100,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Oil',style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                                Divider(),
                                Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${oilStorage!.truncate()}',style: TextStyle(fontSize: 40)),
                                        Text('jerrycan',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
                                      ],
                                    ),
                                    edit?Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Container(
                                      height: 25,
                                      width: 90,
                                      child: TextFormField(
                                        controller: oilToAdd,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      ),
                                      ),
                                    ),
                                    ):Container()
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
              ),
            ],
            ),
            Positioned(child:edit? FloatingActionButton(heroTag: null,onPressed: (){
              if (saltToAdd.text.isNotEmpty) {
                double saltToSend=saltStorage!+double.parse(saltToAdd.text);
                storage.doc(FirebaseAuth.instance.currentUser!.uid).set({
                  'salt':saltToSend
                },
                  SetOptions(merge: true)
                );
              }
              if (yeastToAdd.text.isNotEmpty) {
                double yeastToSend=yeastStorage!+double.parse(yeastToAdd.text);
                storage.doc(FirebaseAuth.instance.currentUser!.uid).set({
                  'yeast':yeastToSend,
                },
                  SetOptions(merge: true)
                );
              }
              if (enhancerToAdd.text.isNotEmpty) {
                double enhancerToSend=enhancerStorage!+double.parse(enhancerToAdd.text);
                storage.doc(FirebaseAuth.instance.currentUser!.uid).set({
                  'enhancer':enhancerToSend,
                },
                  SetOptions(merge: true)
                );
              }
              if (oilToAdd.text.isNotEmpty) {
                double oilToSend=oilStorage!+double.parse(oilToAdd.text);
                storage.doc(FirebaseAuth.instance.currentUser!.uid).set({
                  'oil':oilToSend,
                },
                  SetOptions(merge: true)
                );
              }
              setState(() {
                edit=false;
                oilToAdd.clear();
                saltToAdd.clear();
                enhancerToAdd.clear();
                yeastToAdd.clear();
              });
            },
            backgroundColor:Colors.red,
            child: Text('save'),
            ):FloatingActionButton(heroTag: null,onPressed: (){
              setState(() {
                edit=true;
              });
            },
            backgroundColor: Colors.red[200],
            child: Text('add'),
            ),
            bottom: 30,
            left: 50,
            right: 50,
            )
            ]
          );
        }
      )
    ),
    );
  }
}