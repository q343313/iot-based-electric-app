


part of 'signupbloc.dart';


class SignupStates extends Equatable{

  final String email;
  final String password;
  final String username;
  final String userbio;
  final String userimage;
  final String message;
  final SignupAuthStates signupAuthStates;
  final DateTime dateTime;
  final bool checkbox;

  SignupStates({
    DateTime?dateTime,
    this.message = "",
    this.userimage = "",
    this.userbio = "",
    this.password = "",
    this.checkbox = false,
    this.email = "",
    this.username = "",
    this.signupAuthStates = SignupAuthStates.initial
}):dateTime = dateTime??DateTime.now();

  SignupStates copyWith({
     String?email,
     String?password,
     String?username,
     String?userbio,
     String?userimage,
    bool?checkbox,
     String?message,
     SignupAuthStates?signupAuthStates,
     DateTime?dateTime,
}){
    return SignupStates(
    message: message??this.message,
    email: email??this.email,
    password: password??this.password,
    checkbox: checkbox??this.checkbox,
    username: username??this.username,
    userbio: userbio??this.userbio,
    userimage: userimage??this.userimage,
    signupAuthStates: signupAuthStates??this.signupAuthStates,
    dateTime: dateTime??this.dateTime,
    );
  }

  @override
  List<Object>get props => [message,email,password,userimage,userbio,username,signupAuthStates,dateTime,checkbox];
}