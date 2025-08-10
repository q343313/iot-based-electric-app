


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iot/data/authrepository/authrepository.dart';
import 'package:iot/data/authrepository/firebaseauthentications.dart';
import 'package:iot/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signupstates.dart';
part 'signupevent.dart';


class SignupBloc extends Bloc<SignupEvent,SignupStates>{
  final AuthenticationImplementations authenticationImplementations;
  SignupBloc(this.authenticationImplementations):super(SignupStates()){
    on<AddSignupEmail>(_addemail);
    on<AddSignupPassword>(_addpasswrd);
    on<AddUserImage>(_addimage);
    on<AddUserBio>(_adduserbio);
    on<AddUserName>(_addusername);
    on<AgainInitial>(_againinitial);
    on<CreateUserAccount>(_createuseraccount);
    on<CreateUserProfile>(_createuserprofile);
    on<ResetSignupStates>(_resetallstates);
    on<EnableCheckBox>(_enabledcheckboc);
  }

  _addemail(AddSignupEmail event,Emitter<SignupStates>emit){
    emit(state.copyWith(email: event.email));
  }

  _addpasswrd(AddSignupPassword event,Emitter<SignupStates>emit){
    emit(state.copyWith(password: event.password));
  }
  _addusername(AddUserName event,Emitter<SignupStates>emit){
    emit(state.copyWith(username: event.username));
  }

  _adduserbio(AddUserBio event,Emitter<SignupStates>emit){
    emit(state.copyWith(userbio: event.userbio));
  }

  _addimage(AddUserImage event,Emitter<SignupStates>emit){
    emit(state.copyWith(userimage: event.userimage));
  }

  _createuseraccount(CreateUserAccount event,Emitter<SignupStates>emit)async{
    emit(state.copyWith(signupAuthStates: SignupAuthStates.loading));
    try {

      await authenticationImplementations.signupuser(state.email, state.password);
      final time = "${state.dateTime.day}-${state.dateTime.month}-${state.dateTime.year}";
      var pref = await SharedPreferences.getInstance();
      pref.setString("email", state.email);
      pref.setString("password", state.password);
      pref.setString("datetime", time);
      emit(state.copyWith(signupAuthStates: SignupAuthStates.profile,message: "User Signup Successfully"));

    }on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        emit(state.copyWith(message: e.code.toString(),signupAuthStates: SignupAuthStates.exists));
      }else {
        emit(state.copyWith(signupAuthStates: SignupAuthStates.failure,message: e.code.toString()));
      }
    }
  }

  _againinitial(AgainInitial event,Emitter<SignupStates>emit){
    emit(state.copyWith(signupAuthStates: SignupAuthStates.initial,message: "",email: "",password: "",checkbox: false));
  }


  _createuserprofile(CreateUserProfile event,Emitter<SignupStates>emit)async{
    emit(state.copyWith(signupAuthStates: SignupAuthStates.loading));
    try {

      var pref = await SharedPreferences.getInstance();
      pref.setString("username", state.username);
      pref.setString("userbio", state.userbio);
      pref.setString("userimage", state.userimage);
      await Future.delayed(Duration(seconds: 3));
      emit(state.copyWith(signupAuthStates: SignupAuthStates.success,message: "User profile created successfully"));

    }catch(e){
      emit(state.copyWith(signupAuthStates: SignupAuthStates.failure,message: e.toString()));
    }
  }

  _resetallstates(ResetSignupStates event,Emitter<SignupStates>emit){
    emit(state.copyWith(signupAuthStates: SignupAuthStates.initial,email: "",password: "",userimage: "",username: "",userbio: "",checkbox: false));
  }

  _enabledcheckboc(EnableCheckBox event,Emitter<SignupStates>emit){
    emit(state.copyWith(checkbox: !state.checkbox));
  }

}