import 'package:bakery/database/database.dart';
import 'package:bakery/variables/functions.dart';
import 'package:bakery/variables/variables.dart';
import 'package:bakery/worker/others.dart';
import 'package:flutter/material.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:bakery/manager/settings.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class Worker extends StatefulWidget {
  const Worker({ Key? key }) : super(key: key);

  @override
  _WorkerState createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {

  @override
  void initState() {
    // TODO: implement initState
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
            children:
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                [
                  FutureBuilder(
                    future: getEmployment(),
                    builder: (context,snapshot) {
                      if (isEmployed==null){return CircularProgressIndicator();}
                      else {
                        getRecipe();
                        getSalaries();
                        getStorage();
                        getPrice();
                        return Padding(padding: const EdgeInsets.all(2),
                        child: isEmployed!?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Container(
                              child: Text(' role',
                                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child:Column(
                                  children:
                                  [ 
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:
                                      [
                                        ChoiceChip(label: Text('ajan        ',style: TextStyle(fontSize: 25,color: Colors.black)),
                                          selected: ajan,
                                          backgroundColor: Colors.red[50],
                                          selectedColor: Colors.red[100],
                                          onSelected: (value){
                                            setState(() {
                                              ajan=value;
                                              farran=false;
                                              tawlaji=false;
                                              khazzan=false;
                                              bankaji=false;
                                              role9=1;
                                            });
                                          },
                                          avatar: CircleAvatar(child: Icon(Icons.bakery_dining_outlined),backgroundColor: Colors.red)
                                        ),
                                        ChoiceChip(label: Text('farran    ',style: TextStyle(fontSize: 25,color: Colors.black),),
                                          selected: farran,
                                          backgroundColor: Colors.red[50],
                                          selectedColor: Colors.red[100],
                                          onSelected: (value){
                                            setState(() {
                                              ajan=false;
                                              farran=value;
                                              tawlaji=false;
                                              khazzan=false;
                                              bankaji=false;
                                              role9=2;
                                            });
                                          },
                                          avatar: CircleAvatar(child: Icon(Icons.kitchen),backgroundColor: Colors.red)
                                        )
                                      ]
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:
                                      [
                                        ChoiceChip(label: Text('tawlaji    ',style: TextStyle(fontSize: 25,color: Colors.black)),
                                          selected: tawlaji,
                                          backgroundColor: Colors.red[50],
                                          selectedColor: Colors.red[100],
                                          onSelected: (value){
                                            setState(() {
                                              ajan=false;
                                              farran=false;
                                              tawlaji=value;
                                              khazzan=false;
                                              bankaji=false;
                                              role9=3;
                                            });
                                          },
                                          avatar: CircleAvatar(child: Icon(Icons.table_view_rounded),backgroundColor: Colors.red)
                                        ),
                                        ChoiceChip(label: Text('khazzan',style: TextStyle(fontSize: 25,color: Colors.black)),
                                          selected: khazzan,
                                          backgroundColor: Colors.red[50],
                                          selectedColor: Colors.red[100],
                                          onSelected: (value){
                                            setState(() {
                                              ajan=false;
                                              farran=false;
                                              tawlaji=false;
                                              khazzan=value;
                                              bankaji=false;
                                              role9=4;
                                            });
                                          },
                                          avatar: CircleAvatar(child: Icon(Icons.bakery_dining_outlined),backgroundColor: Colors.red)
                                        ),
                                      ]
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:
                                      [
                                        ChoiceChip(label: Text('bankaji   ',style: TextStyle(fontSize: 25,color: Colors.black)),
                                          selected: bankaji,
                                          backgroundColor: Colors.red[50],
                                          selectedColor: Colors.red[100],
                                          onSelected: (value){
                                            setState(() {
                                              ajan=false;
                                              farran=false;
                                              tawlaji=false;
                                              khazzan=false;
                                              bankaji=value;
                                              role9=5;
                                            });
                                          },
                                          avatar: CircleAvatar(child: Icon(Icons.window),backgroundColor: Colors.red)
                                        ),
                                        ChoiceChip(label: Text('cleaner  ',style: TextStyle(fontSize: 25,color: Colors.black)),
                                          selected: cleaner,
                                          backgroundColor: Colors.red[50],
                                          selectedColor: Colors.red[100],
                                          onSelected: (value){
                                            setState(() {
                                              cleaner=value;
                                            });
                                          },
                                          avatar: CircleAvatar(child: Icon(Icons.kitchen),backgroundColor: Colors.red)
                                        )
                                      ]
                                    )
                                  ]
                                )
                              ),
                            ),
                            (tawlaji|khazzan|ajan|farran)?
                            Column(
                              children: [
                                Container(
                              child: Text(' accomplished work',
                                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child:
                               Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child:(targetValue !=null)?
                                    LinearProgressIndicator()
                                    :
                                    (targetValue==0)?
                                    Align(alignment: Alignment.center, child: Text('No target yet!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)))
                                    :
                                    SingleChildScrollView(
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:
                                      [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: 
                                          [
                                            FloatingActionButton(
                                              heroTag: null,
                                              onPressed: (){
                                                setState(() {
                                                  if (accomplished==0)
                                                  null;
                                                  else
                                                  accomplished--;
                                                });
                                              },
                                              backgroundColor: Colors.red.withOpacity(0.6),
                                              mini: true,
                                              child: Icon(Icons.remove),
                                            ),
                                            Text("${accomplished.truncate()}",
                                              style: TextStyle(
                                              fontSize: 40,
                                              ),
                                            ),
                                            FloatingActionButton(
                                              heroTag: null,
                                              onPressed: (){
                                                setState(() {
                                                  accomplished++;
                                                });
                                              },
                                              backgroundColor: Colors.red.withOpacity(0.6),
                                              mini: true,
                                              child: Icon(Icons.add),
                                            )
                                          ],
                                        ),
                                        Text('doughs made'),
                                        Divider(),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: FloatingActionButton(
                                            heroTag: null,
                                            onPressed: (){
                                              accomplishedCollection.doc(employerId).collection('accomplishes').doc(FirebaseAuth.instance.currentUser!.uid).set(
                                                {
                                                  'ID':FirebaseAuth.instance.currentUser!.uid,
                                                  'name':myName,
                                                  'role':role9,
                                                  'accomplished':accomplished,
                                                  'payment':0,
                                                  'cleanedTrays':tray,
                                                  'cleanedGeneral':generalCleanning
                                                },
                                                SetOptions(merge: true)
                                              );
                                              setState(() {
                                              accomplished=0;
                                              });
                                            },
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.arrow_right_sharp),
                                          ),
                                        ),
                                        cleaner? Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 30),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: 
                                  [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:
                                      [
                                        ChoiceChip(label: Text('   Trays   ',style: TextStyle(fontSize: 25)),
                                          selected: tray,
                                          onSelected: (value){
                                            setState(() {
                                              tray=value;
                                            });
                                          },
                                        ),
                                        ChoiceChip(label: Text(' General ',style: TextStyle(fontSize: 25),),
                                          selected: generalCleanning,
                                          onSelected: (value){
                                            setState(() {
                                              generalCleanning=value;
                                            });
                                          },
                                        )
                                      ]
                                    ),
                                  ],
                                )
                              )
                              
                            )
                            :
                            Container()
                                      ]
                                    )
                                  )
                                )
                            )
                              ],
                            )
                            :
                            Container(),
                            bankaji?
                            Column(
                              children: [
                                Container(
                              child: Text(' accomplished work',
                                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child:
                               Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child:(targetValue !=null)?
                                    LinearProgressIndicator()
                                    :
                                    amIBankaji!?(targetValue==0)?
                                    Align(alignment: Alignment.center, child: Text('No target yet!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)))
                                    :
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: 
                                        [
                                    Text(' Sales status',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                                    Divider(),
                                    Padding(padding:EdgeInsets.all(7),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: 
                                          [
                                            Text('Sold :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                            Container(
                                              height: 30,
                                              width: 100,
                                              child: TextField(
                                                controller: soldValue,
                                                style: TextStyle(fontSize: 20),
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder()
                                                ),
                                              ),
                                            ),
                                            (available>0)? FloatingActionButton(
                                              heroTag: null,
                                              onPressed: (){
                                                setState(() {
                                                  sold9+=double.parse(soldValue.text);
                                                  available=available-double.parse(soldValue.text);
                                                  soldValue.clear();
                                                });
                                                setSoldAndAvailable(priceForB!);
                                              },
                                              backgroundColor: Colors.red,
                                              child: Icon(Icons.arrow_right_sharp),
                                            )
                                            :
                                            Container(),
                                            Container(
                                              child: Text('${sold9.truncate()} / ${available.truncate()}',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ),
                                    Divider(),
                                    Text(' Cuts',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                                    Divider(),
                                    Padding(padding:EdgeInsets.all(7),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children:
                                          [
                                            Container(
                                              height:containerSizeD,
                                              child: ListView(
                                                children: 
                                                [
                                                  (countDoughs==1)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children:   
                                                          [
                                                            Text('15 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut15,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  (countDoughs==1||countDoughs==2)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Text('14 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut14,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  (countDoughs==1||countDoughs==2||countDoughs==3)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Text('13 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut13,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Text('12 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          Container(
                                                            height: 25,
                                                            width: 120,
                                                            child: TextField(
                                                              controller: dCut12,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                              ),
                                                            ),
                                                          ),
                                                          Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                :
                                                Container(),
                                                (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5)
                                                ?Padding(padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: 
                                                    [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Text('11 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          Container(
                                                            height: 25,
                                                            width: 120,
                                                            child: TextField(
                                                              controller: dCut11,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                              ),
                                                            ),
                                                          ),
                                                          Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                :
                                                Container(),
                                                (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                countDoughs==6)
                                                ?Padding(padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: 
                                                    [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Text('10 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          Container(
                                                            height: 25,
                                                            width: 120,
                                                            child: TextField(
                                                              controller: dCut10,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                              ),
                                                            ),
                                                          ),
                                                          Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                :
                                                Container(),
                                                (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                countDoughs==6||countDoughs==7)
                                                ?Padding(padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: 
                                                    [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Text(' 9  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          Container(
                                                            height: 25,
                                                            width: 120,
                                                            child: TextField(
                                                              controller: dCut9,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                              ),
                                                            ),
                                                          ),
                                                          Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                :
                                                Container(),
                                                (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                countDoughs==6||countDoughs==7||countDoughs==8)
                                                ?Padding(padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: 
                                                    [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Text(' 8  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          Container(
                                                            height: 25,
                                                            width: 120,
                                                            child: TextField(
                                                              controller: dCut8,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                              ),
                                                            ),
                                                          ),
                                                          Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                :
                                                Container(),
                                                (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                countDoughs==6||countDoughs==7||countDoughs==8||countDoughs==9)
                                                ?Padding(padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: 
                                                    [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Text(' 7  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          Container(
                                                            height: 25,
                                                            width: 120,
                                                            child: TextField(
                                                              controller: dCut7,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                              ),
                                                            ),
                                                          ),
                                                          Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                :
                                                Container(),
                                                (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                countDoughs==6||countDoughs==7||countDoughs==8||countDoughs==9||countDoughs==10)
                                                ?Padding(padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children:
                                                    [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Text(' 6  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          Container(
                                                            height: 25,
                                                            width: 120,
                                                            child: TextField(
                                                              controller: dCut6,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                              ),
                                                            ),
                                                          ),
                                                          Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                :
                                                Container(),
                                                (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                countDoughs==6||countDoughs==7||countDoughs==8||countDoughs==9||countDoughs==10||
                                                countDoughs==11)
                                                ?Padding(padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: 
                                                    [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Text(' 5  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut5,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                  countDoughs==6||countDoughs==7||countDoughs==8||countDoughs==9||countDoughs==10||
                                                  countDoughs==11||countDoughs==12)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Text(' 4  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut4,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                  countDoughs==6||countDoughs==7||countDoughs==8||countDoughs==9||countDoughs==10||
                                                  countDoughs==11||countDoughs==12||countDoughs==13)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Text(' 3  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut3,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                  countDoughs==6||countDoughs==7||countDoughs==8||countDoughs==9||countDoughs==10||
                                                  countDoughs==11||countDoughs==12||countDoughs==13||countDoughs==14)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Text(' 2  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut2,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  (countDoughs==1||countDoughs==2||countDoughs==3||countDoughs==4||countDoughs==5||
                                                  countDoughs==6||countDoughs==7||countDoughs==8||countDoughs==9||countDoughs==10||
                                                  countDoughs==11||countDoughs==12||countDoughs==13||countDoughs==14||countDoughs==15)
                                                  ?Padding(padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: 
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Text(' 1  : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                            Container(
                                                              height: 25,
                                                              width: 120,
                                                              child: TextField(
                                                                controller: dCut1,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder()
                                                                ),
                                                              ),
                                                            ),
                                                            Text('  Trays ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: 
                                                [
                                                  numberOfDoughs>1? Padding(padding: EdgeInsets.all(10),
                                                    child: FloatingActionButton(onPressed: (){
                                                      setState(() {
                                                        countDoughs++;
                                                        containerSizeD-=containerSizeIncrementD;
                                                        numberOfDoughs--;
                                                        avilableButton=true;                 
                                                      });
                                                    },
                                                    child: Icon(Icons.remove),
                                                    mini: true,
                                                    backgroundColor: Colors.red.withOpacity(0.6),
                                                    heroTag: null,
                                                  ),
                                                  )
                                                  :
                                                  Container(),
                                                  numberOfDoughs<15? Padding(padding: EdgeInsets.all(10),
                                                    child: FloatingActionButton(onPressed: (){
                                                      setState(() {
                                                        countDoughs--;
                                                        containerSizeD+=containerSizeIncrementD;
                                                        numberOfDoughs++; 
                                                        avilableButton=true;                  
                                                      });
                                                    },
                                                    child: Icon(Icons.add),
                                                    mini: true,
                                                    backgroundColor: Colors.red.withOpacity(0.6),
                                                    heroTag: null,
                                                  ),
                                                  )
                                                  :
                                                  Container()
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: 
                                                [
                                                  Text('Corrupted :  ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                  Container(
                                                    height: 30,
                                                    width: 100,
                                                    child: TextField(
                                                      controller: corrupted9,
                                                      style: TextStyle(fontSize: 20),
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder()
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: (avilableButton)?FloatingActionButton(onPressed: (){
                                                  setProducedAndcorruptedAndAvailable();
                                                  setStorage();
                                                  setState(() {
                                                    avilableButton=false;
                                                  });
                                                },
                                                backgroundColor: Colors.red,
                                                child: Icon(Icons.arrow_right_sharp),
                                                heroTag: null,
                                                )
                                                :
                                                Container()
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                    Divider(),
                                    Text(' Workers confirmation',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                                    Divider(),
                                    Padding(padding:EdgeInsets.all(7),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        child:StreamBuilder(
                                          stream:accomplishedCollection.doc(employerId).collection('accomplishes').snapshots() ,
                                          builder:(context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                            var snapshots=snapshot.requireData;
                                            if (!snapshot.hasData){return CircularProgressIndicator();}
                                            else
                                            if (snapshot.hasError){return Text('ERROR',style: TextStyle(fontSize: 30),);}
                                            else {
                                              return 
                                            ListView.builder(itemCount: snapshots.size,
                                              shrinkWrap: true,
                                              itemBuilder: (context,index){
                                                late String roleText;
                                                if(snapshots.docs[index]['role']==1){roleText='ajan';}
                                                else if(snapshots.docs[index]['role']==2){roleText ='farran';}
                                                else if(snapshots.docs[index]['role']==3){roleText='tawlaji';}
                                                else if(snapshots.docs[index]['role']==4){roleText='khazan';}
                                                else if(snapshots.docs[index]['role']==5){roleText='bankaji';}
                                                else {roleText='';}
                                                return
                                                Column(
                                                  children: 
                                                  [
                                                    Row(
                                                      children: 
                                                      [
                                                        Padding(padding: EdgeInsets.all(5),
                                                          child: Icon(Icons.person_pin ,size: 40),
                                                        ),
                                                        Padding(padding: EdgeInsets.all(5),
                                                          child: Text(snapshots.docs[index]['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,))
                                                        )
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Row(
                                                      children: 
                                                      [
                                                        Padding(padding: EdgeInsets.all(2),
                                                          child:Text('role : ',style: TextStyle(fontSize: 17)) ,
                                                        ),
                                                        Padding(padding: EdgeInsets.all(2),
                                                          child:Text(roleText) ,
                                                        ),
                                                      ]
                                                    ),
                                                    Row(
                                                      children: 
                                                      [
                                                        Padding(padding: EdgeInsets.all(2),
                                                          child: Text('accomplished : ',style: TextStyle(fontSize: 17)),
                                                        ),
                                                        Padding(padding: EdgeInsets.all(2),
                                                          child: Text('${snapshots.docs[index]['accomplished'].truncate()}'),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: 
                                                      [
                                                        Padding(padding: EdgeInsets.all(2),
                                                          child: Text('payment : ',style: TextStyle(fontSize: 17)),
                                                        ),
                                                        Padding(padding: EdgeInsets.all(2),
                                                          child: Text('${getPayment(snapshots.docs[index]['accomplished'],snapshots.docs[index]['role'])}')
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: 
                                                      [
                                                        Padding(padding: EdgeInsets.all(5),
                                                          child: FloatingActionButton(heroTag: null,
                                                            onPressed: (){
                                                              double pay=getPayment(snapshots.docs[index]['accomplished'],snapshots.docs[index]['role']);
                                                              accomplishedCollection.doc(employerId).collection('accomplishes').doc(snapshots.docs[index]['ID']).set(
                                                                {
                                                                  'payment':pay
                                                                },
                                                                SetOptions(merge: true)
                                                              );
                                                              payments=pay+payments;
                                                              calculations.doc(employerId).set(
                                                                {
                                                                  'payments':payments
                                                                },
                                                                SetOptions(merge: true)
                                                              );
                                                              final snackBar=SnackBar(content:Text('Paid'));
                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                            },
                                                            backgroundColor:Colors.red,
                                                            child: Icon(Icons.check_outlined),
                                                          ),
                                                        ),
                                                        Padding(padding: EdgeInsets.all(5),
                                                          child: FloatingActionButton(heroTag: null,
                                                            onPressed: (){
                                                              accomplishedCollection.doc(employerId).collection('accomplishes').doc(snapshots.docs[index]['ID']).delete();
                                                              final snackBar=SnackBar(content:Text('Deleted'));
                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                            },
                                                            backgroundColor:Colors.red,
                                                            child: Icon(Icons.clear_outlined),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ]
                                                );
                                              }
                                            );
                                            }
                                          }
                                        )
                                      )
                                    ),
                                    Divider(),
                                    Text(' Expenses',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                                    Divider(),
                                    Padding(padding:EdgeInsets.all(8),
                                      child:
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: 
                                            [
                                              Container(
                                                height:containerSizeE,
                                                child: ListView(
                                                  children: 
                                                  [
                                                    (count==1)?Padding(padding: EdgeInsets.all(8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: 
                                                            [
                                                              Text('5 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                              Container(
                                                                height: 25,
                                                                width: 120,
                                                                child: TextField(
                                                                  controller: expense5,
                                                                  keyboardType: TextInputType.name,
                                                                  decoration: InputDecoration(
                                                                    border: OutlineInputBorder()
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: 
                                                            [
                                                              Text('value : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                              Container(
                                                                height: 25,
                                                                width: 70,
                                                                child: TextField(
                                                                  controller: eValue5,
                                                                  keyboardType: TextInputType.number,
                                                                  decoration: InputDecoration(
                                                                    border: OutlineInputBorder()
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(' SDG',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                    :
                                                    Container(),
                                                    (count==1||count==2)?Padding(padding: EdgeInsets.all(8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: 
                                                        [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: 
                                                            [
                                                              Text('4 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                              Container(
                                                                height: 25,
                                                                width: 120,
                                                                child: TextField(
                                                                  controller: expense4,
                                                                  keyboardType: TextInputType.name,
                                                                  decoration: InputDecoration(
                                                                    border: OutlineInputBorder()
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: 
                                                            [
                                                              Text('value : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                              Container(
                                                                height: 25,
                                                                width: 70,
                                                                child: TextField(
                                                                  controller: eValue4,
                                                                  keyboardType: TextInputType.number,
                                                                  decoration: InputDecoration(
                                                                    border: OutlineInputBorder()
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(' SDG',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      )
                                                      :
                                                      Container(),
                                                    (count==1||count==2||count==3)?Padding(padding: EdgeInsets.all(8),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: 
                                                          [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: 
                                                              [
                                                                Text('3 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                                Container(
                                                                  height: 25,
                                                                  width: 120,
                                                                  child: TextField(
                                                                    controller: expense1,
                                                                    keyboardType: TextInputType.name,
                                                                    decoration: InputDecoration(
                                                                      border: OutlineInputBorder()
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: 
                                                              [
                                                                Text('value : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                                Container(
                                                                  height: 25,
                                                                  width: 70,
                                                                  child: TextField(
                                                                    keyboardType: TextInputType.number,
                                                                    decoration: InputDecoration(
                                                                      border: OutlineInputBorder()
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(' SDG',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        )
                                                        :
                                                        Container(),
                                                        (count==1||count==2||count==3||count==4)?Padding(padding: EdgeInsets.all(8),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: 
                                                            [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: 
                                                                [
                                                                  Text('2 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 120,
                                                                    child: TextField(
                                                                      controller: expense2,
                                                                      keyboardType: TextInputType.name,
                                                                      decoration: InputDecoration(
                                                                        border: OutlineInputBorder()
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: 
                                                                [
                                                                  Text('value : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                                  Container(
                                                                    height: 25,
                                                                    width: 70,
                                                                    child: TextField(
                                                                      controller: eValue2,
                                                                      keyboardType: TextInputType.number,
                                                                      decoration: InputDecoration(
                                                                        border: OutlineInputBorder()
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(' SDG',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          )
                                                          :
                                                          Container(),
                                                          (count==1||count==2||count==3||count==4||count==5)?Padding(padding: EdgeInsets.all(8),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: 
                                                              [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: 
                                                                  [
                                                                    Text('1 : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                                    Container(
                                                                      height: 25,
                                                                      width: 120,
                                                                      child: TextField(
                                                                        controller: expense1,
                                                                        keyboardType: TextInputType.name,
                                                                        decoration: InputDecoration(
                                                                          border: OutlineInputBorder()
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: 
                                                                  [
                                                                    Text('value : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                                                    Container(
                                                                      height: 25,
                                                                      width: 70,
                                                                      child: TextField(
                                                                        controller: eValue1,
                                                                        keyboardType: TextInputType.number,
                                                                        decoration: InputDecoration(
                                                                          border: OutlineInputBorder()
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(' SDG',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            )
                                                            :
                                                            Container(),
                                                          ],
                                                        
                                                ),
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: 
                                                [
                                                  numberOfExpenses>1? Padding(padding: EdgeInsets.all(10),
                                                    child: FloatingActionButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          count++;
                                                          containerSizeE-=containerSizeIncrementE;
                                                          numberOfExpenses--;                 
                                                        });
                                                      },
                                                      child: Icon(Icons.remove),
                                                      mini: true,
                                                      backgroundColor: Colors.red.withOpacity(0.6),
                                                      heroTag: null,
                                                    ),
                                                  )
                                                  :
                                                  Container(),
                                                  numberOfExpenses<5? Padding(padding: EdgeInsets.all(10),
                                                    child: FloatingActionButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          count--;
                                                          containerSizeE+=containerSizeIncrementE;
                                                          numberOfExpenses++;                 
                                                        });
                                                      },
                                                      child: Icon(Icons.add),
                                                      mini: true,
                                                      backgroundColor: Colors.red.withOpacity(0.6),
                                                      heroTag: null,
                                                    ),
                                                  )
                                                  :
                                                  Container()
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                  child: FloatingActionButton(
                                                    onPressed: (){
                                                      if (numberOfExpenses==1)
                                                        {
                                                          expenses.doc(employerId).set(
                                                            {
                                                              'num':numberOfExpenses,
                                                              'e1':expense1.text,
                                                              'e1v':double.parse(eValue1.text)
                                                            },
                                                            SetOptions(merge: true)
                                                          );
                                                        }
                                                        else if (numberOfExpenses==2)
                                                          {
                                                            expenses.doc(employerId).set(
                                                              {
                                                                'num':numberOfExpenses,
                                                                'e1':expense1.text,
                                                                'e1v':double.parse(eValue1.text),
                                                                'e2':expense2.text,
                                                                'e2v':double.parse(eValue2.text),
                                                              },
                                                              SetOptions(merge: true)
                                                            );
                                                          }
                                                        else if (numberOfExpenses==3)
                                                          {
                                                            expenses.doc(employerId).set(
                                                              {
                                                                'num':numberOfExpenses,
                                                                'e1':expense1.text,
                                                                'e1v':double.parse(eValue1.text),
                                                                'e2':expense2.text,
                                                                'e2v':double.parse(eValue2.text),
                                                                'e3':expense3.text,
                                                                'e3v':double.parse(eValue3.text)
                                                              },
                                                              SetOptions(merge: true)
                                                            );
                                                          }
                                                        else if (numberOfExpenses==4)
                                                          {
                                                            expenses.doc(employerId).set(
                                                              {
                                                                'num':numberOfExpenses,
                                                                'e1':expense1.text,
                                                                'e1v':double.parse(eValue1.text),
                                                                'e2':expense2.text,
                                                                'e2v':double.parse(eValue2.text),
                                                                'e3':expense3.text,
                                                                'e3v':double.parse(eValue3.text),
                                                                'e4':expense4.text,
                                                                'e4v':double.parse(eValue4.text),
                                                              },
                                                              SetOptions(merge: true)
                                                            );
                                                          }
                                                        else 
                                                          {
                                                            expenses.doc(employerId).set(
                                                              {
                                                                'num':numberOfExpenses,
                                                                'e1':expense1.text,
                                                                'e1v':double.parse(eValue1.text),
                                                                'e2':expense2.text,
                                                                'e2v':double.parse(eValue2.text),
                                                                'e3':expense3.text,
                                                                'e3v':double.parse(eValue3.text),
                                                                'e4':expense4.text,
                                                                'e4v':double.parse(eValue4.text),
                                                                'e5':expense5.text,
                                                                'e5v':double.parse(eValue5.text)
                                                              },
                                                              SetOptions(merge: true)
                                                            );
                                                          }
                                                        },
                                                        backgroundColor: Colors.red,
                                                        child: Icon(Icons.arrow_right_sharp),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        )
                                      ),
                                      Divider(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: FloatingActionButton(heroTag: null,onPressed: (){
              setState(() {
                bankaji=false;
                numberOfDoughs=1;
                numberOfExpenses=1;
                corrupted.clear();
                eValue1.clear();
                eValue2.clear();
                eValue3.clear();
                eValue4.clear();
                eValue5.clear();
                expense1.clear();
                expense2.clear();
                expense3.clear();
                expense4.clear();
                expense5.clear();
                dCut1.clear();
                dCut2.clear();
                dCut3.clear();
                dCut4.clear();
                dCut5.clear();
                dCut6.clear();
                dCut7.clear();
                dCut8.clear();
                dCut9.clear();
                dCut10.clear();
                dCut11.clear();
                dCut12.clear();
                dCut13.clear();
                dCut14.clear();
                dCut15.clear();
              });
            },
              backgroundColor: Colors.red,
              child:Text('Done', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),)
            ),
          )
                                        ],
                                        ):
                                        Container()
                                )
                            ),
                            cleaner? Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 30),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: 
                                  [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:
                                      [
                                        ChoiceChip(label: Text('   Trays   ',style: TextStyle(fontSize: 25)),
                                          selected: tray,
                                          onSelected: (value){
                                            setState(() {
                                              tray=value;
                                            });
                                          },
                                        ),
                                        ChoiceChip(label: Text(' General ',style: TextStyle(fontSize: 25),),
                                          selected: generalCleanning,
                                          onSelected: (value){
                                            setState(() {
                                              generalCleanning=value;
                                            });
                                          },
                                        )
                                      ]
                                    ),
                                  ],
                                )
                              )
                              
                            )
                            :
                            Align(alignment: Alignment.center, child: Text('You are not allowed :)',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900))),
                              ],
                            )
                            :
                            Container(),
                          ]
                        )
                        :
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child:Column(
                            children:
                            [
                              FloatingActionButton(onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(
                                  body: Center(
                                    child: QrImage(
                                      data: FirebaseAuth.instance.currentUser!.uid,
                                      version: QrVersions.auto,
                                      size: 320,
                                    ),
                                  ),
                                )));},
                              child: const Text('Join',style:TextStyle(fontSize: 16)),
                              backgroundColor: Colors.red
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text('press to join a bakery'),
                              )
                            ]
                          )
                        )
                      );
                      }
                    }
                  )
                ]
              )
            ],
          )
        )
      )
    );
  }
}