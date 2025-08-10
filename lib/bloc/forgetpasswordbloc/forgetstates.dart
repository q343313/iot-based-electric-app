

part of 'forgetbloc.dart';


class ForgetStates extends Equatable{

  final String email;
  final String message;
  final ForgetAuthStates forgetAuthStates;

  ForgetStates({
    this.email = "",
    this.forgetAuthStates = ForgetAuthStates.initial,
    this.message = ""
  });

  ForgetStates copyWith({
     String?email,
     String?message,
     ForgetAuthStates?forgetAuthStates,
}){
  return ForgetStates(
    email: email??this.email,
    message: message??this.message,
    forgetAuthStates: forgetAuthStates??this.forgetAuthStates
  );
}

  @override
  List<Object>get props => [email,message,forgetAuthStates];
}
