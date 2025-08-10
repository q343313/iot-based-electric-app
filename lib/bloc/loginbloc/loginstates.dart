

part of 'loginbloc.dart';


class LoginStates extends Equatable{
  final String email;
  final String password;
  final String message;
  final LoginAuthStates loginAuthStates;

  const LoginStates({
    this.loginAuthStates  = LoginAuthStates.initial,
    this.password = "",
    this.email = "",
    this.message = ""
});

  LoginStates copyWith({
    String?email,
    String?password,
    String?message,
    LoginAuthStates?loginAuthStates
}){
    return LoginStates(
      email: email??this.email,
      message: message??this.message,
      password: password??this.password,
      loginAuthStates: loginAuthStates??this.loginAuthStates
    );
}

  @override
  List<Object>get props => [email,password,message,loginAuthStates];
}