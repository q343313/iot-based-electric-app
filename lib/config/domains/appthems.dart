
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:iot/config/domains/appcolors.dart';



class AppThemes {



  static final ThemeData lightthemedata = ThemeData(

      scaffoldBackgroundColor: AppColors.scaffoldlightmode,

      brightness: Brightness.light,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.textdarkmode),
        bodySmall: TextStyle(color: AppColors.textdarkmode),

      ),

      elevatedButtonTheme: ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),

              backgroundColor: AppColors.buttonlightmode

          )

      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(

        backgroundColor: const Color(0xFF2E7BFF),

        foregroundColor: Colors.white,

        elevation: 8,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),

      ),

      appBarTheme: AppBarTheme(

          backgroundColor: AppColors.scaffoldlightmode

      )

  );

  static final ThemeData darkthemedata = ThemeData(

      scaffoldBackgroundColor: AppColors.scaffolddarkmode,

      brightness: Brightness.dark,


      textTheme: TextTheme(

        bodyLarge: TextStyle(color: AppColors.textdarkmode),

        bodySmall: TextStyle(color: AppColors.textdarkmode),


      ),

      elevatedButtonTheme: ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),

              backgroundColor: AppColors.buttondarkmode

          )

      ),

      appBarTheme: AppBarTheme(

          backgroundColor: AppColors.scaffolddarkmode

      )

  );

}