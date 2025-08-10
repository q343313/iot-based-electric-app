


class AppVallidarions{

  static emailvallidaion(String email){
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    if(email == null || email.isEmpty){
      return "Please enter email";
    }else if(!emailRegex.hasMatch(email)){
      return "Please enter valid email";
    }
    return null;
  }


  static passwordvallidation(String password){
    if(password == null || password.isEmpty){
      return "Please enter password";
    }
    else if(password.length < 6){
      return "Please enter greater than 6 letter password";
    }
    return null;
  }


  static usernamevallidation(String username){
    if(username == null || username.isEmpty){
      return "Please enter username";
    }else if(username.length > 20){
      return "Please enter name less than 20 letter";
    }
    return null;
  }

  static userbiovallidation(String userbio){
    if(userbio == null || userbio.isEmpty){
      return "Please enter username";
    }else if(userbio.length > 100){
      return "Please enter name less than 20 letter";
    }
    return null;
  }

}