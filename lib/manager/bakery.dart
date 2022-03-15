import 'package:bakery/database/database.dart';
import 'package:bakery/variables/functions.dart';
import 'package:bakery/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Bakery extends StatefulWidget {
  const Bakery({ Key? key }) : super(key: key);

  @override
  _BakeryState createState() => _BakeryState();
}

class _BakeryState extends State<Bakery> {
  static bool working=false;
  double netProfit=0;
  double done=0;
  double av=0;
  double so=0;
  double pa=0;
  double pr=0;
  double ex=0;
  double numOfExpenses=0;
  double ex1v=0;
  double ex2v=0;
  double ex3v=0;
  double ex4v=0;
  double ex5v=0;
  String? ex1;
  String? ex2;
  String? ex3;
  String? ex4;
  String? ex5;
  getDone()async{
    setState(()async {
      await calculations.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) =>done=value['doughsDone']);
    });
  }
  getAv()async{
    setState(()async {
      await calculations.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) =>av=value['available']);
    });
  }
  getSo()async{
    setState(()async {
      await calculations.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) =>so=value['sold']);
    });
  }
  getPr()async{
    setState(()async {
      await calculations.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) =>pr=value['profit']);
    });
  }
  getPa()async{
    setState(()async {
      await calculations.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) =>pa=value['payments']);
    });
  }
  getEx()async{
    setState(()async {
      await calculations.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) =>
      {numOfExpenses=value['num'],
      if (numOfExpenses==1)
      {
        ex1=value['e1'],
        ex1v=value['e1v']
      },
      if (numOfExpenses==2)
      {
        ex1=value['e1'],
        ex1v=value['e1v'],
        ex2=value['e2'],
        ex2v=value['e2v']
      },
      if (numOfExpenses==3)
      {
        ex1=value['e1'],
        ex1v=value['e1v'],
        ex2=value['e2'],
        ex2v=value['e2v'],
        ex3=value['e3'],
        ex3v=value['e3v'],
      },
      if (numOfExpenses==4)
      {
        ex1=value['e1'],
        ex1v=value['e1v'],
        ex2=value['e2'],
        ex2v=value['e2v'],
        ex3=value['e3'],
        ex3v=value['e3v'],
        ex4=value['e4'],
        ex4v=value['e4v']
      },
      if (numOfExpenses==5)
      {
        ex1=value['e1'],
        ex1v=value['e1v'],
        ex2=value['e2'],
        ex2v=value['e2v'],
        ex3=value['e3'],
        ex3v=value['e3v'],
        ex4=value['e4'],
        ex4v=value['e4v'],
        ex5=value['e5'],
        ex5v=value['e5v']
      },
      });
    });
  }
  calEx(){
    ex=ex1v+ex2v+ex3v+ex4v+ex5v;
  }
  @override
  void initState() {
    // TODO: implement initState
    getDone();
    getAv();
    getSo();
    getPr();
    getEx();
    getPa();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //Future w= Accomplished.getAllAccomplished(FirebaseAuth.instance.currentUser!.uid);
    //List wo=Accomplished().getAccomplishedList();
    return Scaffold(backgroundColor: Colors.red.withOpacity(0.05),
      body: SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children:[ Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children:[
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text('Production status',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:EdgeInsets.all(7),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 130,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child:Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Target',style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                              Divider(),
                              working?Text('${target.text}',style: TextStyle(fontSize: 60,)): Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 60,
                                    child: TextField(
                                      controller: target,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder()
                                      ),
                                    ),
                                  ),
                                  FloatingActionButton(onPressed: (){
                                    /////////////
                                    //if (target.value==null){}
                                    /////////////
                                    //else {
                                      calculations.doc(FirebaseAuth.instance.currentUser!.uid).set(
                                      {
                                        'target':double.parse(target.text)
                                      },
                                      SetOptions(merge: true)
                                    );
                                    setState(() {
                                      working=true;
                                    });
                                    //}
                                  },
                                  mini: true,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.arrow_right_sharp),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                    Padding(
                      padding:EdgeInsets.all(7),
                      child: Container(
                        height: 130,
                        width: 160,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Done',style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                            Divider(),
                            Text('${done.truncate()}',style: TextStyle(fontSize: 60,)),
                          ],
                        ),
                      )
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text('Sales status',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:EdgeInsets.all(7),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 130,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Available',style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                            Divider(),
                            Text('${av.truncate()}',style: TextStyle(fontSize: 60,))
                          ],
                        ),
                      )
                    ),
                    Padding(
                      padding:EdgeInsets.all(7),
                      child: Container(
                        height: 130,
                        width: 160,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Sold',style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                            Divider(),
                            Text('${so.truncate()}',style: TextStyle(fontSize: 60,))
                          ],
                        ),
                      )
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text('Working shift',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
                 Padding(padding:EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: 
                StreamBuilder(stream: accomplishedCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection('accomplishes').snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData){return Align(alignment: Alignment.center, child: Text('No one did anything yet !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900)));}
                  else {
                  var snapshots=snapshot.requireData;
                  return ListView.builder(itemCount: snapshots.size,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                    late String role;
                    if(snapshots.docs[index]['role']==1){role='ajan';}
                    else if(snapshots.docs[index]['role']==2){role ='farran';}
                    else if(snapshots.docs[index]['role']==3){role='tawlaji';}
                    else if(snapshots.docs[index]['role']==4){role='khazan';}
                    else if(snapshots.docs[index]['role']==5){role='bankaji';}
                    else {role='';}
                    return Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: 
                            [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                child: Icon(Icons.person_pin ,size: 30),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5),
                              child: Text('${snapshots.docs[index]['name']}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,))
                              ),
                              Padding(padding: EdgeInsets.only(top: 5),
                              child: Text('${snapshots.docs[index]['accomplished']} as a '+role,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,))
                              ),
                              Padding(padding: EdgeInsets.only(top: 5,right: 5),
                              child:(snapshots.docs[index]['payment']==0)? const CircularProgressIndicator()
                              :
                              Text('${snapshots.docs[index]['payment']} (SDG)',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,))
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    );
                  }
                  );}
                }
                )
                )),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text('Expenses',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(padding:EdgeInsets.all(5),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        (numOfExpenses==0)?Align(alignment: Alignment.center, child: Text('No expenses yet !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900))):Container(),
                        (numOfExpenses==1)?Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(5),
                        child: Text(ex1!,style: TextStyle(fontSize: 20)),
                        ),
                        Padding(padding: EdgeInsets.all(5),
                        child: Text('${ex1v}',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    )
                    ):Container(),
                    (numOfExpenses==2)?Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(5),
                        child: Text(ex2!,style: TextStyle(fontSize: 20)),
                        ),
                        Padding(padding: EdgeInsets.all(5),
                        child: Text('${ex2v}',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    )
                    ):Container(),
                    (numOfExpenses==3)?Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(5),
                        child: Text(ex3!,style: TextStyle(fontSize: 20)),
                        ),
                        Padding(padding: EdgeInsets.all(5),
                        child: Text('${ex3v}',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    )
                    ):Container(),
                    (numOfExpenses==4)?Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(5),
                        child: Text(ex4!,style: TextStyle(fontSize: 20)),
                        ),
                        Padding(padding: EdgeInsets.all(5),
                        child: Text('${ex4v}',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    )
                    ):Container(),
                    (numOfExpenses==5)?Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(5),
                        child: Text(ex5!,style: TextStyle(fontSize: 20)),
                        ),
                        Padding(padding: EdgeInsets.all(5),
                        child: Text('${ex5v}',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    )
                    ):Container(),
                      ],
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text('Financial status',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
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
                            Text('profits',style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                            Divider(),
                            Text('${pr}',style: TextStyle(fontSize: 30,))
                          ],
                        ),
                      )
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Expenses',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('salaries :    ',style: TextStyle(fontSize: 18,)),
                                Text('${pa}',style: TextStyle(fontSize: 30,))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('expenses :  ',style: TextStyle(fontSize: 18,)),
                                Text('${ex}',style: TextStyle(fontSize: 30,))
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                    Padding(
                      padding:EdgeInsets.all(7),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Net profit',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                            Divider(),
                            Text('${netProfit}',style: TextStyle(fontSize: 30,))
                          ],
                        ),
                      )
                    ),
                  ],
                ),
                working? Positioned(child: Padding(padding: EdgeInsets.all(15),
                  child:FloatingActionButton(heroTag: null,onPressed: (){
                    calculations.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'target':0,
                        'cuts':0,
                        'doughsDone':0,
                        'available':0,
                        'profit':0,
                        'payments':0,
                        'sold':0
                        },
                        SetOptions(merge: true)
                      );
                      expenses.doc(FirebaseAuth.instance.currentUser!.uid).set({
                        'num':0,
                        },
                      );
                      accomplishedCollection.doc(FirebaseAuth.instance.currentUser!.uid).delete();
                      setState(() {
                        netProfit=0;
                        working=false;
                      });
                  },
                    backgroundColor: Colors.red,
                    child: Text('Done', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                  ) ,
                  ),
                  bottom: 50,
                  left: 50,
                  right: 50,
                ):Container()
              ],
              
          ),
          ]
        ),
      )
    ),
    );
  }
}