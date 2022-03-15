import 'package:bakery/database/database.dart';
import 'package:bakery/worker/others.dart';
import 'package:flutter/material.dart';
import 'package:bakery/variables/collections.dart';
import 'package:bakery/variables/controllers.dart';
import 'package:bakery/manager/settings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


//bool activityStatus=false;

bool locationValidation=false;

var workersCheck;
var workingsCheck;

var bakeryIcon;
var userIcon;

bool? isEmployed;

String? employerId;
String? myName;

bool? amIBankaji;

bool? targetV;
double? targetValue;


double available=0,sold9=0;

double? oilInRecipeValue,enhancerInRecipeValue,saltInRecipeValue,yeastInRecipeValue;

double? oilInStorage,enhancerInStorage,saltInStorage,yeastInStorage;


double? ajanSalaryValue,farranSalaryValue,tawlajiSalaryValue,khazanSalaryValue;

double? produced,corruptedValue;

double cuts=0;



   bool 
    ajan=false,
    farran=false,
    tawlaji=false,
    bankaji=false,
    khazzan=false,
    cleaner=false,
    avilableButton=true,
    tray=false,
    generalCleanning=false;

   double 
    count=5,
    role9=0,
    cuts9=0,
    cutsToSen9=0,
    corruptedToSend9=0,
    numberOfDoughs=1,
    numberOfDoughsToSend9=0,
    numberOfExpenses=1,
    sold=0,
    accomplished=0,
    profit=0,
    countExpenses=5,
    countDoughs=15,
    containerSizeE=50,
    containerSizeIncrementE=42,
    containerSizeD=50,
    containerSizeIncrementD=42;
    