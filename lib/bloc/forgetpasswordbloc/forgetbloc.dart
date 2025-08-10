



import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iot/data/authrepository/firebaseauthentications.dart';
import 'package:iot/utils/enums.dart';

part 'forgetevent.dart';
part 'forgetstates.dart';


class ForgetBloc extends Bloc<ForgetEvent,ForgetStates>{
  final AuthenticationImplementations authenticationImplementations;
  ForgetBloc(this.authenticationImplementations):super(ForgetStates()){
    on<AddForgetEmail>(_addemail);
    on<SendEmailForgetPassword>(_forgetpasswrdo);
    on<ResetForgetStates>(_resetstates);
  }

  _addemail(AddForgetEmail event,Emitter<ForgetStates>emit){
    emit(state.copyWith(email: event.email));
  }

  _forgetpasswrdo(SendEmailForgetPassword event,Emitter<ForgetStates>emit)async{
    emit(state.copyWith(forgetAuthStates: ForgetAuthStates.loading));
    try {

      await authenticationImplementations.resetpassword(state.email);
      emit(state.copyWith(forgetAuthStates: ForgetAuthStates.success,message: "Send email to reset password"));

    }on FirebaseAuthException catch(e){
      emit(state.copyWith(forgetAuthStates: ForgetAuthStates.failure,message: e.code.toString()));
    }
  }

  _resetstates(ResetForgetStates event,Emitter<ForgetStates>emit){
    emit(state.copyWith(forgetAuthStates: ForgetAuthStates.initial,message: "",email: ""));
  }


}