


abstract class AuthRepository{
 Future<dynamic>signupuser(String email,String password);
 Future<dynamic>loginuser(String email,String password);
 Future<dynamic>logoutuser();
 Future<dynamic>resetpassword(String email);
}