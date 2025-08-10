import 'package:iot/allpaths.dart';

class AuthAllButtons extends StatelessWidget {
  AuthAllButtons({super.key});

  TextEditingController usernamecontroller= TextEditingController();
  TextEditingController userbiocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomSingleButton(icon: Icon(Icons.logout), title: "logout",callback: (){
          authdialog(context: context, callback: (){
            context.read<LoginBloc>().add(LogoutUserAccount());
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Logout User", message: "user logout successfully");
            Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
          });
        },),
        CustomSingleButton(icon: Icon(Icons.delete,color: Colors.red,), title: "delete",callback: (){
          authdialog(context: context, callback: (){
            context.read<LoginBloc>().add(LogoutUserAccount());
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Delete User", message: "user Deleted account successfully");
            Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
          });
        },),
        CustomSingleButton(icon: Icon(Icons.edit), title: "edit",callback: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Updateduseerprofiles()));
        },)
      ],
    );
  }
}

Future<void>authdialog({
  required BuildContext context,
  String?title,
  String?buttonname,
  String?content,
  required VoidCallback callback
}
    ){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(title??"Logout User",style: TextStyle(
        fontFamily: "semibold",fontSize: 20,
      ),),
      content: Text(content??"You want to logout you profile account if you logout your account you must be created new account"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel",style: TextStyle(color: Colors.blue,fontSize: 16,fontFamily: "semibold"),)),
        TextButton(onPressed: (){
          Navigator.pop(context);
          callback();
        }, child: Text(buttonname??"logout",style: TextStyle(color: Colors.red,fontSize: 16,fontFamily: "semibold"),))
      ],
    );
  });
}


class CustomSingleButton extends StatelessWidget {
  const CustomSingleButton({super.key,required this.icon,required this.title,required this.callback});

  final Icon icon;
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SizedBox(
        width: 78,
        height: 66,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(30),
          child: Card(
            shape: Border.all(
              color: Theme.of(context).brightness == Brightness.dark?
              AppColors.scaffoldlightmode:
              AppColors.scaffolddarkmode,
            ),
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.textfielddarkmode
                :AppColors.textfieldlightmode,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(title)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}