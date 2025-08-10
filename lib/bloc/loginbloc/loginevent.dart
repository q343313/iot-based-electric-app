



part of 'loginbloc.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object>get props => [];
}

class AddLoginEmail extends LoginEvent{
  final String email;
  AddLoginEmail({required this.email});
  @override
  List<Object>get props => [email];
}

class AddLoginPassword extends LoginEvent{
  final String password;
  AddLoginPassword({required this.password});
  @override
  List<Object>get props => [password];
}

class LoginUserAccount extends LoginEvent{}
class ResetLoginStates extends LoginEvent{}
class LogoutUserAccount extends LoginEvent{}