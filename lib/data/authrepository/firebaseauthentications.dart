



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class AuthenticationImplementations{

  loginuser(String email, String password)async{
   await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  logoutuser()async{
   await FirebaseAuth.instance.signOut();
  }

  resetpassword(String email)async{
   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  signupuser(String email, String password)async{
    UserCredential credential  = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }


  Future<void> chatwithwhatsapp() async {
    final phone = "923182586785";
    final url = "https://wa.me/$phone?text=Hello";

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Cannot launch $url");
      throw "Could not open WhatsApp";
    }
  }

  addiotdatainflutter()async{

    final database  = FirebaseDatabase.instance.ref("iotdata");
    await database.child("roomdata").set({
      "voltage":0.0,
      "current":0.0,
      "power":0.0,
      "state":"Stop"
    });
  }

  updateddata({required double voltage,required double currnet,required double power})async{
    final data = FirebaseDatabase.instance.ref("iotdata");
    await data.child("roomdata").update({
      "voltage":voltage,
      "current":currnet,
      "power":power,
      "state":"running"
    });
  }
}