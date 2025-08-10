


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customintroscreenwidget extends StatelessWidget {
  const Customintroscreenwidget({
    super.key,
    required this.image,
    required this.title1,
    required this.title2,
    required this.title3
  });

  final String image;
  final String title1;
  final String title2;
  final String title3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/$image"),width: 300,height: 300,),
              SizedBox(height: 15.h,),
              Text(title1,style: TextStyle(fontFamily: "semibold",fontSize: 25),),
              Text(title2,style: TextStyle(fontFamily: "semibold",fontSize: 25),),
              Text(title3,style: TextStyle(fontFamily: "semibold",fontSize: 25),)

            ],
          ),
        ),
      ),
    );
  }
}
