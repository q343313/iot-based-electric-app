



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:iot/config/routes/routenames.dart';

class SplashServices {

  static islogin(BuildContext context)async{
    final user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(seconds: 4));
    if(user != null){
      Navigator.pushReplacementNamed(context, RoutesNames.homescreen);
    }else {
      Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
    }
  }

}