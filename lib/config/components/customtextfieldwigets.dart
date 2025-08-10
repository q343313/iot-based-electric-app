


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfieldwidget extends StatelessWidget {
  CustomTextfieldwidget({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    required this.label,
    this.func,
    this.obstractext = false,
    this.onTap,
    this.validator,
    this.icon,
    this.suffixixon,
    this.color
  });

  final TextEditingController controller;
  final bool obstractext;
  final TextInputType textInputType;
  final Function(String)?func;
  final String label;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final Icon?icon;
  final IconButton?suffixixon;
  final Color?color;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: color ?? Colors.black),
      controller: controller,
      onChanged: func,
      onTap: onTap,
      validator: validator,
      obscureText: obstractext,
      keyboardType: textInputType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: color ?? Colors.lightBlueAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: color ?? Colors.lightBlueAccent),
          ),
          label: Text(label, style: TextStyle(fontFamily: "semibold",
              fontSize: 16,
              color: color ?? Colors.black),),
          prefixIcon: icon,
          suffixIcon: suffixixon
      ),
    );
  }
}