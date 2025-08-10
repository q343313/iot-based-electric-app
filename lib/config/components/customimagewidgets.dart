

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iot/bloc/imagebloc/imagebloc.dart';

class Customimagewidgets extends StatelessWidget {
  const Customimagewidgets({super.key,this.image = "",this.radius = 60});

  final String image;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white54,
          backgroundImage: image != null && image.isNotEmpty?
              FileImage(File(image)):null,
          child: image == null || image.isEmpty?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt,color: Colors.blue,),
                    Text("upload image",style: TextStyle(color: Colors.blue),)
                  ],
                ),
              ):null,
        ),
        Positioned(
          bottom: 0.9,
            right: 0,
            child: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.camera_alt,color: Colors.white,),

        ))
      ],
    );
  }
}


Future<void>showimagedialog(BuildContext context){
  return showModalBottomSheet(context: context, builder: (context){
    return Container(
      height: 180.h,
      child: Column(
        children: [
          CustomListtile(icon: Icon(Icons.library_add), callback: (){
            Navigator.pop(context);
            context.read<ImageBloc>().add(GalleryCapture());
          }, title: "From library"),
          CustomListtile(icon: Icon(Icons.camera_alt_rounded), callback: (){
            Navigator.pop(context);
            context.read<ImageBloc>().add(CameraCapture());
          }, title: "From Camera"),
          CustomListtile(icon: Icon(Icons.delete,color: Colors.red,), callback: (){
            Navigator.pop(context);
            context.read<ImageBloc>().add(DeleteImage());
          }, title: "Delete Image")
        ],
      ),
    );
  });
}


class CustomListtile extends StatelessWidget {
   CustomListtile({super.key,required this.icon,required this.callback,required this.title});

  final VoidCallback callback;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      leading: icon,
      title: Text(title),
    );
  }
}
