
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iot/data/services/splashservices/splashscreenservices.dart';

class Splashscreens extends StatefulWidget {
  const Splashscreens({super.key});

  @override
  State<Splashscreens> createState() => _SplashscreensState();
}

class _SplashscreensState extends State<Splashscreens> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashServices.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF009688),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/light.png"),width:300,height:300),
            SizedBox(height: 20,),
          ],
        ),
      ),
      floatingActionButton:  Text("IOT ELECTRIC APP",style:TextStyle(fontFamily: "bold",color: Colors.white,fontSize: 30)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
