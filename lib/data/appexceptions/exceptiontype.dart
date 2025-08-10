

import 'package:iot/data/appexceptions/appexceptions.dart';

class UserNotFoundExceptions extends AppExceptions{
  UserNotFoundExceptions([String?message]):super(message,"User Not Found");
}

class UnAutherizedExceptions extends AppExceptions{
  UnAutherizedExceptions([String?message]):super(message,"UnAuthorized Exceptions");
}

class NoInterNetExceptions extends AppExceptions{
  NoInterNetExceptions([String?message]):super(message,"No Internet Exception");
}

class DefaultExcptions extends AppExceptions{
  DefaultExcptions([String?message]):super(message,"Default exceptions occures");
}

class VallidationExceptions extends AppExceptions{
  VallidationExceptions([String?message]):super(message,"Vallidations exceptions");
}

class BadRequestExceptions extends AppExceptions{
  BadRequestExceptions([String?message]):super(message,"Bad Request exceptions");
}

class RequestTimeOuytExceptions extends AppExceptions{
  RequestTimeOuytExceptions([String?message]):super(message,"Requests timeout exceptions");
}