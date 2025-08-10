

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthSocialMediaButtons extends StatelessWidget {
  const AuthSocialMediaButtons({super.key,required this.callback,required this.buttonname,required this.text});

  final String text;
  final String buttonname;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Expanded(child: Divider()),
              SizedBox(width: 3.w,),
              Text("OR",style: TextStyle(color: Colors.white,fontFamily: "bold",fontSize: 20),),
              SizedBox(width: 3.h,),
              Expanded(child: Divider()),
            ],
          ),
        ),
        SizedBox(height: 15.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: AssetImage("assets/images/go1.jpg"),),
            SizedBox(width: 8.w,),
            CircleAvatar(backgroundImage: AssetImage("assets/images/ph1.png"),)
          ],
        ),
        SizedBox(height: 30.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: TextStyle(color: Colors.white,fontSize: 16.sp,fontFamily: "semibold"),),
            TextButton(onPressed:callback, child: Text(buttonname,style: TextStyle(color: Colors.red,fontSize: 16.sp,fontFamily: "semibold"),))
          ],
        )
      ],
    );
  }
}