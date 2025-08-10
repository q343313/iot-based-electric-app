import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import for responsive sizing
import 'package:iot/config/domains/appcolors.dart';

class CustomSnackbarWidets {
  static void awesoemsnackbarwidget({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0, // No default elevation
      behavior: SnackBarBehavior.floating, // Allows margin
      backgroundColor: Colors.transparent, // Transparent background for custom content
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h), // Responsive margin
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar() // Hide any current snackbar before showing a new one
      ..showSnackBar(snackBar);
  }

  static void flusbarsnackbar({
    required BuildContext context,
    required String title,
    required String message,
    Color? color,
    Icon? icon,
  }) {
    Flushbar(
      icon: icon ?? Icon(Icons.info_outline, color: Colors.white, size: 28.w), // Default icon with responsive size
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3), // Auto-dismiss after 3 seconds
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h), // Responsive margin
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), // Responsive padding
      borderRadius: BorderRadius.circular(15.r), // Responsive border radius
      boxShadows: [
        BoxShadow(
          color: (color ?? AppColors.buttondarkmode).withOpacity(0.4), // Use provided color for shadow
          blurRadius: 8.r,
          offset: Offset(0, 4.h),
        ),
      ],
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp, // Responsive font size
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14.sp, // Responsive font size
        ),
      ),
      backgroundColor: color ?? (Theme.of(context).brightness == Brightness.dark ? AppColors.buttondarkmode : Colors.blue.shade600), // Dynamic background color
      // If you want a subtle border:
      // borderColor: Colors.white24,
      // borderWidth: 0.5,
    ).show(context);
  }
}