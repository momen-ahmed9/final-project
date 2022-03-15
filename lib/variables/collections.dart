import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

 var users= FirebaseFirestore.instance.collection('users');
 var storage= FirebaseFirestore.instance.collection('storage');
 var expenses= FirebaseFirestore.instance.collection('expenses');
 var products= FirebaseFirestore.instance.collection('products');
 var recipe= FirebaseFirestore.instance.collection('recipe');
 var salaries= FirebaseFirestore.instance.collection('salaries');
 var calculations= FirebaseFirestore.instance.collection('calculations');
 var orders= FirebaseFirestore.instance.collection('orders');
 var accomplishedCollection= FirebaseFirestore.instance.collection('accomplished');
 var workers= FirebaseFirestore.instance.collection('workers');
 var reports= FirebaseFirestore.instance.collection('reports');
 var allReports= FirebaseFirestore.instance.collection('allReports');
 