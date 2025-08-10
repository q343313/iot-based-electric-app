



class AppExceptions implements Exception{

  final _preffix;
  final _message;

  AppExceptions([this._message,this._preffix]);

  @override
  String toString() {
    return "$_preffix $_message";
  }

}