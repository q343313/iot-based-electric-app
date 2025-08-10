


part of 'forgetbloc.dart';


abstract class ForgetEvent extends Equatable{
  @override
  List<Object>get props => [];
}

class AddForgetEmail extends ForgetEvent{
  final String email;
   AddForgetEmail({required this.email});
   @override
  List<Object>get props => [email];
}

class SendEmailForgetPassword extends ForgetEvent{}
class ResetForgetStates extends ForgetEvent{}

