


part of 'updatedbloc.dart';


class UpdatedStates extends Equatable{
  final String username;
  final String userbio;
  final String image;
  final String message;
  final String email;

  const UpdatedStates({
    this.userbio = "",
    this.username = "",
    this.image = "",
    this.message = "",
    this.email = ""
});

  UpdatedStates copyWith({
    String?username,
    String?userbio,
    String?image,
    String?message,
    String?email
}){
    return UpdatedStates(
      userbio: userbio??this.userbio,
      username: username??this.username,
      image: image??this.image,
      message: message??this.message,
      email: email??this.email
    );
}

  @override
  List<Object>get props => [username,userbio,image,message,email];
}