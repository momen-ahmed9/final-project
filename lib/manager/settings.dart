import 'package:bakery/manager/settings%20map.dart';
import 'package:bakery/variables/functions.dart';
import 'package:bakery/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/manager/qr_scanner.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakery/manager/bakery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bakery/database/database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng? locationOfBakery;


class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {
  //Future w= Workers.getAllWorkers();
  //List wo=Workers().getWorkersList();
  final settingsFormKey = GlobalKey<FormState>();
   var scannedQrcode;
   var haveBakery = false;
    Future isHaveBakery()async {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => {haveBakery =value['haveBakery']});
    }

  bool? isBankaji;
  Future isHeBankaji(String id)async {
    await FirebaseFirestore.instance.collection('users').doc(id).get().then((value) => {isBankaji=value['bankaji']});
  }

   bool editMode=false;

   int numberOfProducts=1;
   double containerSize=60;
   double containerSizeIncrement=47;

   @override
   void initState() {
    isHaveBakery();
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.05),
      body: SafeArea(child: SingleChildScrollView(
        child:Form(
          key: settingsFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(' Information',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding:EdgeInsets.all(8),
                      child: Container(
                        padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('bakery name : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                            Container(
                              height: 25,
                              width: 240,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter your bakery name";
                                  }
                                },
                                keyboardType: TextInputType.name,
                                controller: bakeryName,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('bread price : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                              height: 25,
                              width: 80,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter bread price";
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: price,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text(' SDG',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                              ],
                            )
        
                          ],
                        ),
                      ],
                    ), 
                      )
                    ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(' Workers Salaries',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bankaji :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the bankaji's salary";
                                  }
                                },
                                controller: bankajiSalary,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   SDG per single day                     ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
        
                      ],
                    ), 
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Farran :    ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the farran's salary";
                                  }
                                },
                                controller: farranSalary,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   SDG per single dough                ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ajan :       ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the ajan's salary";
                                  }
                                },
                                controller: ajanSalary,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   SDG per single dough                ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tawlagy :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the tawlaji's salary";
                                  }
                                },
                                controller: tawlajiSalary,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   SDG per single dough                ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Khazan : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the khazan's salary";
                                  }
                                },
                                controller: khazanSalary,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   SDG per single dough                ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                  ],
                )
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(5),
                child: Text(' Reipe',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Yeast :   ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 50,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the quantity of yeast";
                                  }
                                },
                                controller: yeastInRecipe,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   pack in each flour sack                  ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enhancer :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 50,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the quantity of enhancer";
                                  }
                                },
                                controller: enhancerInRecipe,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   envelope in each flour sack           ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Salt :     ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 50,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the quantity of salt";
                                  }
                                },
                                controller: saltInRecipe,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('   sack in each flour sack                   ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(' Oil:          ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: 50,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter the quantity of oil";
                                  }
                                },
                                controller: oilInRecipe,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                            ),
                            Text('  % of a jerrycan in each flour sack  ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ), 
                    ),
                  ],
                )
                ),
              ),
              FutureBuilder(
                   future: isHaveBakery(),
                   builder: (context,snapshot){
                     return Padding(padding: EdgeInsets.all(15),
                  child: 
                    haveBakery?Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                child: Text(' Workers',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),
                ),
              ),
               Padding(padding:EdgeInsets.all(7),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [ 
                        StreamBuilder(
                          stream: workers.doc(FirebaseAuth.instance.currentUser!.uid).collection('allWorkers').snapshots(),
                          builder:(context,AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData){return Align(alignment: Alignment.center, child: Text('No workers yet!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)));}
                            else{
                            var snapshots=snapshot.requireData;
                              return ListView.builder(itemCount: snapshots.size,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              return Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(padding: EdgeInsets.all(5),
                                          child: Icon(Icons.person_pin ,size: 40),
                                        ),
                                        Padding(padding: EdgeInsets.all(5),
                                          child:Text(snapshots.docs[index]['name'],
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)
                                          )
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(padding: EdgeInsets.all(5),
                                          child: FutureBuilder(
                                            future: isHeBankaji(snapshots.docs[index]['ID']),
                                            builder: (context,snapshot){
                                              if (isBankaji!)
                                              {
                                                return ElevatedButton(onPressed: ()
                                                {
                                                  users.doc((snapshots.docs[index]['ID'])).set(
                                                    {
                                                      'bankaji':false
                                                    },
                                                    SetOptions(merge: true)
                                                  );
                                                }, 
                                                child:Text('Make not bankaji'),
                                                style: ElevatedButton.styleFrom(primary: Colors.grey)
                                                );
                                              }
                                              else
                                              {
                                                return ElevatedButton(onPressed: ()
                                                {
                                                  users.doc((snapshots.docs[index]['ID'])).set(
                                                    {
                                                      'bankaji':true
                                                    },
                                                    SetOptions(merge: true)
                                                  );
                                                }, 
                                                child:Text('Make bankaji'),
                                                style: ElevatedButton.styleFrom(primary: Colors.red),
                                                );
                                              }
                                            }
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(5),
                                          child: FloatingActionButton(onPressed: ()
                                          {
                                            workers.doc(FirebaseAuth.instance.currentUser!.uid).collection('allWorkers').doc(snapshots.docs[index]['ID']).delete();
                                          },
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.remove),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              );
                            }
                          );
                            
                          }}
                        ),
                        FloatingActionButton(onPressed:  () async{
                          String? result;
                          String? name;
                          bool? exist;
                          result = await Navigator.of(context).push(MaterialPageRoute( builder: (context) => QRScanner() ));
                          await users.doc(result!).get().then((value) => exist=value.exists);
                          if  (!exist!)
                          {
                            final snackBar=SnackBar(content:Text('Not a user!'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          else
                          {
                            await users.doc(result).get().then((value) => name=value['userName']);
                              workers.doc(FirebaseAuth.instance.currentUser!.uid).collection('allWorkers').doc(result).set(
                                {
                                  'ID':result.toString(),
                                  'name':name!
                                },
                                SetOptions(merge: true)
                              );
                            users.doc(result).set({'isEmployed':true,'employerId':(FirebaseAuth.instance.currentUser!.uid).toString()},SetOptions(merge: true));
                            final snackBar=SnackBar(content:Text('Worker added'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                          child: Icon(Icons.add),
                          mini: true,
                          backgroundColor: Colors.red.withOpacity(0.6),
                        ),
                        Divider(),
                        
                      ],
                    )
                  )
                )
                      ],
                    ):Container());}),
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Padding(padding: EdgeInsets.all(15),
                 child:
                    FloatingActionButton(
                    heroTag: null,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingnsMap()));
                    },
                    child: Icon(Icons.pin_drop),
                    backgroundColor: locationValidation?(Colors.red):(Colors.grey),
                  ),   
                 ),
                 FutureBuilder(
                   future: isHaveBakery(),
                   builder: (context,snapshot){
                     return Padding(padding: EdgeInsets.all(15),
                  child: 
                    haveBakery?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                editMode=true;
                              });
                            },
                            child: Text('Edit settings'),
                            style: ElevatedButton.styleFrom(primary: Colors.red),
                          ),
                        ),
                        editMode? FloatingActionButton(
                          onPressed: (){  
                             List<String> splitlist = bakeryName.text.split(' ');
                              List<String> indexList = [];
                              for (int i = 0; i < splitlist.length; i++) {
                                for (int j = 1;
                                    j < splitlist[i].length + 1;
                                    j++) {
                                  indexList.add(splitlist[i]
                                      .substring(0, j)
                                      .toLowerCase());
                                }
                              }
                      products.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'price':int.parse(price.text),'bakeryName':bakeryName.text,'ID':FirebaseAuth.instance.currentUser!.uid,'available':0,'location':GeoPoint(locationOfBakery!.latitude,locationOfBakery!.longitude),'SearchIndex': indexList
                      },
                        SetOptions(merge: true)
                      );
                      salaries.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'bankajiSalary':double.parse(bankajiSalary.text),
                        'farranSalary':double.parse(farranSalary.text),
                        'ajanSalary':double.parse(ajanSalary.text),
                        'tawlajiSalary':double.parse(tawlajiSalary.text),
                        'khazanSalary':double.parse(khazanSalary.text),
                      },
                        SetOptions(merge: true)
                      );
                      recipe.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'yeast':double.parse(yeastInRecipe.text),
                        'enhancer':double.parse(enhancerInRecipe.text),
                        'salt':double.parse(saltInRecipe.text),
                        'oil':double.parse(oilInRecipe.text),
                       },
                        SetOptions(merge: true)
                       );
                      setState(() {
                        editMode=false;
                      });
                          },
                          child: Icon(Icons.save),
                          backgroundColor: Colors.red,
                        ):Container()  
                      ],
                    ): ElevatedButton(onPressed:
                    (){
                      if (settingsFormKey.currentState!.validate())
                      {
                       if (locationValidation) {
                      List<String> splitlist = bakeryName.text.split(' ');
                              List<String> indexList = [];
                              for (int i = 0; i < splitlist.length; i++) {
                                for (int j = 1;
                                    j < splitlist[i].length + 1;
                                    j++) {
                                  indexList.add(splitlist[i]
                                      .substring(0, j)
                                      .toLowerCase());
                                }
                              }
                      products.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'price':double.parse(price.text),'bakeryName':bakeryName.text,'ID':FirebaseAuth.instance.currentUser!.uid,'available':0,'location':GeoPoint(locationOfBakery!.latitude,locationOfBakery!.longitude),'SearchIndex': indexList
                        },
                        SetOptions(merge: true)
                      );
                      //products.set({'price':price.text,'bakeryName':bakeryName.text,'ID':FirebaseAuth.instance.currentUser!.uid});
                      salaries.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'bankajiSalary':double.parse(bankajiSalary.text),
                        'farranSalary':double.parse(farranSalary.text),
                        'ajanSalary':double.parse(ajanSalary.text),
                        'tawlajiSalary':double.parse(tawlajiSalary.text),
                        'khazanSalary':double.parse(khazanSalary.text),
                        },
                        SetOptions(merge: true)
                      );
                      recipe.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'yeast':double.parse(yeastInRecipe.text),
                        'enhancer':double.parse(enhancerInRecipe.text),
                        'salt':double.parse(saltInRecipe.text),
                        'oil':double.parse(oilInRecipe.text),
                        },
                        SetOptions(merge: true)
                      );
                      calculations.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'target':0,
                        'produced':0,
                        'corrupted':0,
                        'doughsDone':0,
                        'available':0,
                        'profit':0,
                        'payments':0,
                        'sold':0
                        },
                        SetOptions(merge: true)
                      );
                      storage.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'yeast':0,
                        'enhancer':0,
                        'oil':0,
                        'salt':0
                        },
                        SetOptions(merge: true)
                      );
                      expenses.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'num':0
                        },
                        SetOptions(merge: true)
                      );
                      setState(() {
                        users.doc(FirebaseAuth.instance.currentUser!.uid).set({'haveBakery':true},SetOptions(merge: true));
                        final snackBar=SnackBar(content:Text('Bakery created'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      }
                      else{
                        setState(() {
                          final snackBar=SnackBar(content:Text('Set your bakery location'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    }},
                    child: Text('create a bakery account',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  )
                  );
                   }
                  )
               ],
            )
            ],
          ),
        ) ,
      )),
    );
  }
}















                   
