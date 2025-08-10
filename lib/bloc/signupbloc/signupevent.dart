


part of 'signupbloc.dart';


abstract class SignupEvent extends Equatable{
  @override
  List<Object>get props => [];
}

class AddSignupEmail extends SignupEvent{
  final String email;
  AddSignupEmail({required this.email});
  @override
  List<Object>get props=> [email];
}

class AddSignupPassword extends SignupEvent{
  final String password;
  AddSignupPassword({required this.password});
  @override
  List<Object>get props => [password];
}

class AddUserName extends SignupEvent{
  final String username;
  AddUserName({required this.username});
  @override
  List<Object>get props => [username];
}


class AddUserBio extends SignupEvent{
  final String userbio;
  AddUserBio({required this.userbio});
  @override
  List<Object>get props => [userbio];
}

class AddUserImage extends SignupEvent{
  final String userimage;
  AddUserImage({required this.userimage});
  @override
  List<Object>get props => [userimage];
}

class CreateUserAccount extends SignupEvent{}
class CreateUserProfile extends SignupEvent{}
class EnableCheckBox extends SignupEvent{}
class ResetSignupStates extends SignupEvent{}
class AgainInitial extends SignupEvent{}