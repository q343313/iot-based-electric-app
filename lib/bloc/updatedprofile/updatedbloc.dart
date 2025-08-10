


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'updatedstates.dart';
part 'updateevents.dart';


class UpdatedBloc extends Bloc<UpdatedEvent,UpdatedStates>{
  UpdatedBloc():super(UpdatedStates()){
    on<AddUpdatedUserbio>(_userbio);
    on<AddUpdatedUsername>(_username);
    on<AddUpdatedImages>(_addupdatedimage);
    on<UpdatedUserProfile>(_updateduser);
    on<ResetUpdatreStates>(_resetstate);
    on<AddEmailUpadated>(_useremail);
  }

  _addupdatedimage(AddUpdatedImages event,Emitter<UpdatedStates>emit)async{
    var pref = await SharedPreferences.getInstance();
    pref.setString("userimage", event.image);
    emit(state.copyWith(image: event.image));
  }

  _username(AddUpdatedUsername event,Emitter<UpdatedStates>emit){
    emit(state.copyWith(username: event.username));
  }

  _useremail(AddEmailUpadated event,Emitter<UpdatedStates>emit){
    emit(state.copyWith(email: event.email));
  }

  _userbio(AddUpdatedUserbio event,Emitter<UpdatedStates>emit){
    emit(state.copyWith(userbio: event.userbio));
  }

  _updateduser(UpdatedUserProfile event,Emitter<UpdatedStates>emit)async{
    var pref = await SharedPreferences.getInstance();
    if(state.username != ""|| state.username.isNotEmpty&& state.userbio != "" || state.userbio.isNotEmpty){
      pref.setString("username", state.username);
      pref.setString("userbio", state.userbio);
    }
    emit(state.copyWith(message: "User Profile Updated Successfully"));
  }

  _resetstate(ResetUpdatreStates event,Emitter<UpdatedStates>emit){
    emit(state.copyWith(userbio: "",username: "",image: ""));
  }

}