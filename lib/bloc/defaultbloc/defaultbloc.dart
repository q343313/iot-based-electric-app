


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'defaultstates.dart';
part 'defaultevents.dart';


class DefaultBloc extends Bloc<DefaultEvent,DefaultStates>{
  DefaultBloc():super(DefaultStates()){
    on<ShowHidePassword>((ShowHidePassword event,Emitter<DefaultStates>emit){
      emit(state.copyWith(showpassword: !state.showpassword));
    });
  }
}