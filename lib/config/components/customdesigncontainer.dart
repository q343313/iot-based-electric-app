


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignCustomContainer extends StatelessWidget {
  const DesignCustomContainer({super.key, required this.title,this.widget});

  final String title;
  final Widget?widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:Theme.of(context).brightness == Brightness.light?
          [
            Colors.lightBlueAccent,
            Colors.green,
          ]:
              [
                Colors.black54,
                Colors.white12,
              ], begin: Alignment.topLeft),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100),
              bottomLeft: Radius.circular(100))
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 65,),
        Text(title, style: TextStyle(
            color: Colors.white, fontSize: 25.sp, fontFamily: "bold"),),
        SizedBox(height: 15.h,),
        ?widget
        ],
      ),
    ),
    );
  }
}