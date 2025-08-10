

part of'updatedbloc.dart';


abstract class UpdatedEvent extends Equatable{
  @override
  List<Object>get props => [];
}

class AddUpdatedImages extends UpdatedEvent{
  final String image;
  AddUpdatedImages({required this.image});
  @override
  List<Object>get props => [image];
}

class AddUpdatedUsername extends UpdatedEvent{
  final String username;
  AddUpdatedUsername({required this.username});
  @override
  List<Object>get props => [username];
}

class AddUpdatedUserbio extends UpdatedEvent{
  final String userbio;
  AddUpdatedUserbio({required this.userbio});
  @override
  List<Object>get props => [userbio];
}

class AddEmailUpadated extends UpdatedEvent{
  final String email;
  AddEmailUpadated({required this.email});
  @override
  List<Object>get props => [email];
}


class UpdatedUserProfile extends UpdatedEvent{}
class ResetUpdatreStates extends UpdatedEvent{}