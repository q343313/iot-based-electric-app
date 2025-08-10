

import 'package:flutter/material.dart';
import 'package:iot/config/routes/routenames.dart';
import 'package:iot/views/authscreens/forgetpassword/forgetpassword.dart';
import 'package:iot/views/authscreens/loginscreens/loginscreens.dart';
import 'package:iot/views/authscreens/signupscreens/profilescreens.dart';
import 'package:iot/views/authscreens/signupscreens/signupscreens.dart';
import 'package:iot/views/navigationsbarscreens/navigationsbarscreens.dart';
import 'package:iot/views/navigationsbarscreens/profilescreens/updateduseerprofiles.dart';
import 'package:iot/views/splashscreens/splashscreens.dart';

class Routes{
  
  static Route<dynamic>generateroute(RouteSettings setting){
    switch(setting.name){
      case RoutesNames.splashscreens:
        return MaterialPageRoute(builder: (context)=>Splashscreens());
      case RoutesNames.signupscreens:
        return MaterialPageRoute(builder: (context)=>Signupscreens());
      case RoutesNames.loginscreens:
        return MaterialPageRoute(builder: (context)=>Loginscreens());
      case RoutesNames.forgetpassword:
        return MaterialPageRoute(builder: (context)=>Forgetpassword());
      case RoutesNames.addprofiledata:
        return MaterialPageRoute(builder: (context)=>Profilescreens());
      case RoutesNames.homescreen:
        return MaterialPageRoute(builder: (context)=>Navigationsbarscreens());
      case RoutesNames.editprofile:
        return MaterialPageRoute(builder: (context)=>Updateduseerprofiles());
      default:
        return MaterialPageRoute(builder: (context){
          return Scaffold(
            body: Center(
              child: Text("No Route Founds",style: TextStyle(fontSize: 23,fontFamily: "bold"),),
            ),
          );
        });
    }
  }
  
}