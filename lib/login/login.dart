
import 'package:bakery/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakery/variables/collections.dart';
class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}
class _Login extends State<Login>{
  late String verId;
  late String phone;
  var userName=TextEditingController();
  bool codeSent=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('welcome'),
      centerTitle: true,backgroundColor: Colors.red,),
      body: 
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.account_circle_sharp,
                size: 140,
                color: Colors.redAccent),
                Center(
                  child: Text('Sign up',
                  style:TextStyle(fontSize: 30) 
                  ),
                ),
                 
                codeSent? Column(
                  children: [
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 40,
                    style: TextStyle(fontSize: 30),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin){
                      verifyPin(pin);
                      
                    },
                  ),
                  ],
                 )
                 :
                 Column(
                   children: [
                      Padding(padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('name : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                          Container(
                            height: 35,
                            width: 280,
                            child: TextField(
                              controller: userName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder()
                              ),
                            ),
                          ),
                        ],
                      ),
                 ),
                     Container(
                       child: IntlPhoneField(
                         initialCountryCode: '',
                         onChanged: (PhoneNumber){
                           setState(() {
                             phone =PhoneNumber.completeNumber;
                           });
                         },
                       )
                     ),
                     RaisedButton(onPressed: (){
                      verifyPhone();
                      },
                      child: Text('sign up'),
                      color: Colors.red,
                      textColor: Colors.white,
                    )
                   ],
                 ),
               ],
               
             ),
           ),
         ),
      );
    
  }
  Future <void> verifyPhone() async{ 
    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phone,
    verificationCompleted: (PhoneAuthCredential credential ) async{
      await FirebaseAuth.instance.signInWithCredential(credential);
      final snackBar=SnackBar(content:Text('login successfully'));
      var currentUser= await FirebaseAuth.instance.currentUser;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
     
    }, 
    verificationFailed: (FirebaseAuthException e){
      final snackBar =SnackBar(content: Text('${e.message}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }, 
    codeSent: (String  verificationId, int? resendToken){
      setState(() {
        codeSent = true;
        verId = verificationId;
      });
    }, codeAutoRetrievalTimeout: (String verificationId ){
      setState(() {
        verId= verificationId;
      });
    },
    timeout: Duration(seconds: 100)
    );
  }
  Future<void> verifyPin(String pin) async {
    bool? exist;
    String? idOfUser;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);
    
    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) => idOfUser=value.user!.uid);
      await users.doc(idOfUser).get().then((value) => exist=value.exists);
      if (exist!){}
      else{
        users.doc(idOfUser).set(
          {
            'userName':userName.text,
            'userId':idOfUser,
            'employerId':'',
            'haveBakery':false,
            'isEmployed':false,
            'bankaji':false
        },
        SetOptions(merge: true));
      };
      final snackBar=SnackBar(content:Text('login successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
    }on FirebaseAuthException catch(e){
      final snackBar=SnackBar(content:Text('${e.message}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
