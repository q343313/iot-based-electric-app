import 'package:iot/allpaths.dart';


class Loginscreens extends StatefulWidget {
   const Loginscreens({super.key});

  @override
  State<Loginscreens> createState() => _LoginscreensState();
}

class _LoginscreensState extends State<Loginscreens> with TickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller  =AnimationController(vsync: this,duration: Duration(seconds: 3))..repeat();
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DesignCustomContainer(title: "Wellcome Back"),
        
              SizedBox(height: 40,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 38),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomTextfieldwidget(
                        controller: emailcontroller,
                        func: (value)=>context.read<LoginBloc>().add(AddLoginEmail(email: value)),
                        validator: (value)=>AppVallidarions.emailvallidaion(value.toString()),
                        label: 'Email',
                        color: Colors.white,
                        icon: Icon(Icons.email, color: Colors.white,),
                      ),

                      SizedBox(height: 10.h,),
                      BlocBuilder<DefaultBloc, DefaultStates>(
                        builder: (context, state) {
                          return CustomTextfieldwidget(
                            obstractext: state.showpassword,
                            func: (value)=>context.read<LoginBloc>().add(AddLoginPassword(password: value)),
                            validator: (value)=>AppVallidarions.passwordvallidation(value.toString()),
                            controller: passwordcontroller,
                            label: 'Password',
                            suffixixon: IconButton(onPressed: (){
                              context.read<DefaultBloc>().add(ShowHidePassword());
                            }, icon: Icon(state.showpassword?Icons.visibility:Icons.visibility_off,color: Colors.white,)),
                            color: Colors.white,
                            icon: Icon(Icons.password, color: Colors.white,),
                          );
          },
        ),
                     Align(alignment: Alignment.topRight,
                     child: TextButton(onPressed: (){
                       Navigator.pushNamed(context, RoutesNames.forgetpassword);
                     }, child: Text("Forget Password?",style: TextStyle(fontFamily: "semibold",fontSize: 20),)),),
                      SizedBox(height: 40.h,),
                      LoginActionButton(formkey: formkey,controller: controller,emailcontroller: emailcontroller,passwordcontroller: passwordcontroller,),
                      SizedBox(height:20.h),
                      AuthSocialMediaButtons(callback:() {
                        Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
                      },
                        buttonname: 'Signup', text: "Don't have account?",)
                    ],
                  ),
                ),)
            ],
          ),
        ),
      ),
);
  }
}

class LoginActionButton extends StatelessWidget {
   const LoginActionButton({super.key,required this.controller,required this.formkey,required this.passwordcontroller,required this.emailcontroller});

  final AnimationController controller;
  final GlobalKey<FormState>formkey;
  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
  listener: (context, state) {
    if(state.loginAuthStates == LoginAuthStates.success){
      context.read<LoginBloc>().add(ResetLoginStates());
      Navigator.pushReplacementNamed(context, RoutesNames.homescreen);
      CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Login Succesfull", message: state.message);
      emailcontroller.clear();
      passwordcontroller.clear();
    }else if(state.loginAuthStates == LoginAuthStates.notexists){
      context.read<LoginBloc>().add(ResetLoginStates());
      Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
      CustomSnackbarWidets.flusbarsnackbar(context: context, title: "User Not Exists", message: state.message,color: Colors.orange);
      emailcontroller.clear();
      passwordcontroller.clear();
    }else if(state.loginAuthStates == LoginAuthStates.failure){
      context.read<LoginBloc>().add(ResetLoginStates());
      CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Login Failed", message: state.message,color: Colors.red);
      emailcontroller.clear();
      passwordcontroller.clear();
    }
  },
  child: SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
          onPressed: (){
            if(formkey.currentState!.validate()){
              final email = context.read<LoginBloc>().state;
              print(email.email);
              print(email.password);
              context.read<LoginBloc>().add(LoginUserAccount());
            }
          },
          child: BlocBuilder<LoginBloc,LoginStates>(builder: (context,state){
            switch(state.loginAuthStates){
              case LoginAuthStates.loading:
               return Center(
                 child: SpinKitFadingCircle(
                   controller: controller,
                   color: Colors.white,
                 ),
               );
              case LoginAuthStates.success:
              case LoginAuthStates.notexists:
              case LoginAuthStates.initial:
              case LoginAuthStates.failure:
                return Text("Login",style: TextStyle(fontSize: 24.sp,fontFamily: "bold",color: Colors.white),);
            }
          })),
    )
);
  }
}
