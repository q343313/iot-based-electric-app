


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:iot/data/authrepository/firebaseauthentications.dart';
import 'package:iot/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'loginstates.dart';
part 'loginevent.dart';


class LoginBloc extends Bloc<LoginEvent,LoginStates>{
  final AuthenticationImplementations authenticationImplementations;
  LoginBloc(this.authenticationImplementations):super(LoginStates()){
    on<AddLoginPassword>(_addpassword);
    on<AddLoginEmail>(_addemail);
    on<LoginUserAccount>(_loginuser);
    on<ResetLoginStates>(_resetstates);
    on<LogoutUserAccount>(_logoutuser);
  }

  _addemail(AddLoginEmail event,Emitter<LoginStates>emit){
    emit(state.copyWith(email: event.email));
  }

  _addpassword(AddLoginPassword event,Emitter<LoginStates>emit){
    emit(state.copyWith(password: event.password));
  }

  _loginuser(LoginUserAccount event,Emitter<LoginStates>emit)async{
    emit(state.copyWith(loginAuthStates: LoginAuthStates.loading));
    try {

      await authenticationImplementations.loginuser(state.email, state.password);
      var pref = await SharedPreferences.getInstance();
      pref.setString("email", state.email);
      pref.setString("password", state.password);
      emit(state.copyWith(loginAuthStates: LoginAuthStates.success,message: "User Login Successfully"));

    }on FirebaseAuthException catch(e){
      if(e.code == "invalid-credential"){
        emit(state.copyWith(loginAuthStates: LoginAuthStates.notexists,message: e.code.toString()));
      }else {
        emit(state.copyWith(loginAuthStates: LoginAuthStates.failure,message: e.code.toString()));
      }
    }
  }

  _resetstates(ResetLoginStates event,Emitter<LoginStates>emit){
    emit(state.copyWith(loginAuthStates: LoginAuthStates.initial,email: "",password: ""));
  }


  _logoutuser(LogoutUserAccount event,Emitter<LoginStates>emit)async{
    try {
        await authenticationImplementations.logoutuser();
        var pref = await SharedPreferences.getInstance();
        pref.remove("email");
        pref.remove("password");
        emit(state.copyWith(message: "user logout successfully"));
    }on FirebaseAuthException catch(e){
      emit(state.copyWith(message: "user logout Failed"));
    }
  }

}