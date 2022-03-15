  
  
import 'package:bakery/database/database.dart';
import 'package:bakery/variables/variables.dart';
import 'package:bakery/worker/others.dart';
import 'package:flutter/material.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:bakery/manager/settings.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
  
  Future getEmployment()async{
    await users.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => {isEmployed =value['isEmployed'],employerId=value['employerId'],amIBankaji =value['bankaji']});
  }

  Future getTarget()async{
    await calculations.doc(employerId).get().then((value) => {targetValue=value['target']});
  }

  getRecipe()async{
    await recipe.doc(employerId!).get().then((value) => 
      {
        oilInRecipeValue=value['oil'],
        yeastInRecipeValue=value['yeast'],
        enhancerInRecipeValue=value['enhancer'],
        saltInRecipeValue=value['salt']
      });
  }


  getStorage()async{
    await storage.doc(employerId!).get().then((value) => 
      {
        oilInStorage=value['oil'],
        yeastInStorage=value['yeast'],
        enhancerInStorage=value['enhancer'],
        saltInStorage=value['salt']
      });
  }


  getSalaries()async{
    await salaries.doc(employerId!).get().then((value) => 
      {
        ajanSalaryValue=value['ajanSalary'],
        farranSalaryValue=value['farranSalary'],
        khazanSalaryValue=value['khazanSalary'],
        tawlajiSalaryValue=value['tawlajiSalary']
      });
  }

  double getPrice(){
    var price;
    products.doc(employerId!).get().then((value) => price=value['price']);
    return price;
  }

 Future getManCheck()async{
   await workers.doc(FirebaseAuth.instance.currentUser!.uid).collection('allWorkers').get().then((value) => {workersCheck=value.docs.length});
   await accomplishedCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection('accomplishes').get().then((value) => {workingsCheck=value.docs.length});
 }
  


  setSoldAndAvailable(double price){
    double profit=sold9*price;
    calculations.doc(employerId!).set
    (
      {
        'available':available,
        'sold':sold9,
        'profit':profit
      },
      SetOptions(merge: true)
    );
  }

  setStorage(){
    storage.doc(employerId!).set
    (
      {
        'oil':oilInStorage!-(oilInRecipeValue!*numberOfDoughs),
        'enhancer':enhancerInStorage!-(enhancerInRecipeValue!*numberOfDoughs),
        'salt':saltInStorage!-(saltInRecipeValue!*numberOfDoughs),
        'yeast':yeastInStorage!-(yeastInRecipeValue!*numberOfDoughs),
      },
      SetOptions(merge: true)
    );
  }

  
  setProducedAndcorruptedAndAvailable(){
    
    if (numberOfDoughs==1)
    {
      cuts+=(double.parse(dCut1.text));
    }
    else if (numberOfDoughs==2)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
    }
    else if (numberOfDoughs==3)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
    }
    else if (numberOfDoughs==4)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
    }
    else if (numberOfDoughs==5)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
    }
    else if (numberOfDoughs==6)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
    }
    else if (numberOfDoughs==7)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
    }
    else if (numberOfDoughs==8)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
    }
    else if (numberOfDoughs==9)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
      cuts+=(double.parse(dCut9.text));
    }
    else if (numberOfDoughs==10)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
      cuts+=(double.parse(dCut9.text));
      cuts+=(double.parse(dCut10.text));
    }
    else if (numberOfDoughs==11)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
      cuts+=(double.parse(dCut9.text));
      cuts+=(double.parse(dCut10.text));
      cuts+=(double.parse(dCut11.text));
    }
    else if (numberOfDoughs==12)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
      cuts+=(double.parse(dCut9.text));
      cuts+=(double.parse(dCut10.text));
      cuts+=(double.parse(dCut11.text));
      cuts+=(double.parse(dCut12.text));
    }
    else if (numberOfDoughs==13)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
      cuts+=(double.parse(dCut9.text));
      cuts+=(double.parse(dCut10.text));
      cuts+=(double.parse(dCut11.text));
      cuts+=(double.parse(dCut12.text));
      cuts+=(double.parse(dCut13.text));
    }
    else if (numberOfDoughs==14)
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
      cuts+=(double.parse(dCut9.text));
      cuts+=(double.parse(dCut10.text));
      cuts+=(double.parse(dCut11.text));
      cuts+=(double.parse(dCut12.text));
      cuts+=(double.parse(dCut13.text));
      cuts+=(double.parse(dCut14.text));
    }
    else
    {
      cuts+=(double.parse(dCut1.text));
      cuts+=(double.parse(dCut2.text));
      cuts+=(double.parse(dCut3.text));
      cuts+=(double.parse(dCut4.text));
      cuts+=(double.parse(dCut5.text));
      cuts+=(double.parse(dCut6.text));
      cuts+=(double.parse(dCut7.text));
      cuts+=(double.parse(dCut8.text));
      cuts+=(double.parse(dCut9.text));
      cuts+=(double.parse(dCut10.text));
      cuts+=(double.parse(dCut11.text));
      cuts+=(double.parse(dCut12.text));
      cuts+=(double.parse(dCut13.text));
      cuts+=(double.parse(dCut14.text));
      cuts+=(double.parse(dCut15.text));
    }
    produced=cuts*10;
    corruptedValue=(double.parse(corrupted9.text));
    available=produced!-corruptedValue!;
    calculations.doc(employerId!).set
    (
      {
        'available':available,
        'corrupted':corrupted,
        'produced':produced
      },
      SetOptions(merge: true)
    );
  }

  double getPayment(double accomplished,double role){
    late double payment,salary;
    if (role==1){salary=ajanSalaryValue!;}
    else if (role==2){salary=farranSalaryValue!;}
    else if (role==3){salary=tawlajiSalaryValue!;}
    else {salary=khazanSalaryValue!;}
    payment=accomplished*salary;
    return payment;
  }