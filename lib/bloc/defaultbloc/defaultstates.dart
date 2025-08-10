


part of 'defaultbloc.dart';


class DefaultStates extends Equatable{
  final bool showpassword;
  DefaultStates({this.showpassword  = false});
  DefaultStates copyWith({bool?showpassword}){
    return DefaultStates(showpassword: showpassword??this.showpassword);
  }
  @override
  List<Object>get props => [showpassword];
}