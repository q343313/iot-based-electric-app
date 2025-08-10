


import 'package:bloc/bloc.dart';
import 'package:iot/bloc/themebloc/themestates.dart';

class ThemeCubits extends Cubit<ThemeStates>{
  ThemeCubits():super(LightThemeStates());

  toggletheme(){
    if(state is LightThemeStates){
      emit(DarkThemeStates());
    }else {
      emit(LightThemeStates());
    }
  }

  lighttheme(){
    if(state is DarkThemeStates){
      emit(LightThemeStates());
    }else {
      emit(LightThemeStates());
    }
  }

  darktheme(){
    if(state is LightThemeStates){
      emit(DarkThemeStates());
    }else {
      emit(DarkThemeStates());

    }
  }

}