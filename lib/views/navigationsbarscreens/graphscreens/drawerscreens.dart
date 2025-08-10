
import 'dart:io';
import 'package:iot/allpaths.dart';


class Drawerscreens extends StatefulWidget {
  const Drawerscreens({super.key});

  @override
  State<Drawerscreens> createState() => _DrawerscreensState();
}

class _DrawerscreensState extends State<Drawerscreens> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
      ? AppColors.textfielddarkmode
      : AppColors.scaffoldlightmode,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h,),
            ReusableRowWidget(),
            Divider(),
            CustomColoumnwidget(
                cardtitle: "Theme Data",widget: Column(
              children: [
                ReusableListtileAction(icon: Icon(Icons.light,color: Colors.white,),callback: (){
                  BlocProvider.of<ThemeCubits>(context).toggletheme();
                },title: "Theme",),
                ReusableListtileAction(icon: Icon(Icons.light_mode,color: Colors.white,),callback: (){
                  BlocProvider.of<ThemeCubits>(context).lighttheme();
                },title: "Light theme",),
                ReusableListtileAction(icon: Icon(Icons.dark_mode,color: Colors.black,),callback: (){
                  BlocProvider.of<ThemeCubits>(context).darktheme();
                },title: "Dart theme",),
              ],
            ),),
            SizedBox(height: 6,),
            CustomColoumnwidget(
              cardtitle: "Profile Data",widget: Column(
              children: [
                ReusableListtileAction(icon: Icon(Icons.logout,color: Colors.white,),callback: (){
                  authdialog(context: context, callback: (){
                    context.read<LoginBloc>().add(LogoutUserAccount());
                    CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Delete User", message: "user Deleted account successfully");
                    Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
                  });
                },title: "Logout user",),
                ReusableListtileAction(icon: Icon(Icons.delete,color: Colors.red,),callback: (){
                  authdialog(context: context,
                      title: "Delete User",
                      buttonname: "Delete",
                      content: "If you delete your account next time you must be created new account",
                      callback: (){
                    context.read<LoginBloc>().add(LogoutUserAccount());
                    CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Delete User", message: "user Deleted account successfully");
                    Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
                  });
                },title: "Delete account",),
                ReusableListtileAction(icon: Icon(Icons.account_circle_rounded,color: Colors.white,),callback: (){
                  authdialog(context: context,
                      title: "Create New",
                      buttonname: "Create",
                      content: "If you create your new account.The old account will remove automatically.",
                      callback: (){
                    context.read<LoginBloc>().add(LogoutUserAccount());
                    CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Delete User", message: "user Deleted account successfully");
                    Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
                  });
                },title: "Create New",),
                ReusableListtileAction(icon: Icon(Icons.edit,color: Colors.white,),callback: (){
                      Navigator.pushNamed(context, RoutesNames.editprofile);
                },title: "Updated profile",),
              ],
            ),),
        
            SizedBox(height: 6,),
            CustomColoumnwidget(
                cardtitle: "Settings",
            widget: Column(
              children: [
                ReusableListtileAction(icon: Icon(Icons.upgrade,color: Colors.white,),callback: (){},title: "Upgrade",),
                ReusableListtileAction(icon: Icon(Icons.upgrade,color: Colors.white,),callback: (){},title: "Upgrade",),
                ReusableListtileAction(icon: Icon(Icons.upgrade,color: Colors.white,),callback: (){},title: "Upgrade",),
                ReusableListtileAction(icon: Icon(Icons.upgrade,color: Colors.white,),callback: (){},title: "Upgrade",),
              ],
            ),)
        
          ],
        ),
      ),
    );
  }
}

class CustomColoumnwidget extends StatelessWidget {
  const CustomColoumnwidget({super.key,required this.widget,required this.cardtitle});

  final String cardtitle;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.light
      ?Color(0XFF009688)
      :AppColors.textfielddarkmode,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 21.0),
                child: Text(cardtitle,style: TextStyle(color: Colors.white,fontFamily: "bolc",fontSize: 23),),
              )),
          SizedBox(height: 7,),
          widget
        ],
      ),
    );
  }
}



class ReusableListtileAction extends StatelessWidget {
  const ReusableListtileAction({super.key,required this.icon,required this.callback,required this.title});

  final VoidCallback callback;
  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      title: Text(title,style: TextStyle(fontSize: 20,fontFamily: "semibold",color: Colors.white),),
      leading: icon,
      trailing: Icon(Icons.double_arrow_outlined,color: Colors.white,),
    );
  }
}



class ReusableRowWidget extends StatelessWidget {
  const ReusableRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),
            );
          }else if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            final data = snapshot.data!;
            final iamge = data.getString("userimage").toString();
            final username = data.getString("username").toString();
            final useremail = data.getString("email").toString();
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(File(iamge)),
                    radius: 50,
                  ),
                  SizedBox(width: 5,),
                  Column(
                    children: [
                      Text(username,style: TextStyle(fontSize: 17,fontFamily: "semibold"),),
                      Text(useremail,style: TextStyle(fontSize: 12,fontFamily: "semibold",color: Colors.purple),)
                    ],
                  )
                ],
              ),
            );
          }
        });
  }
}
