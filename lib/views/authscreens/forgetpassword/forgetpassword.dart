
import 'package:iot/allpaths.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword>with TickerProviderStateMixin {
  late AnimationController controller;
  TextEditingController emailcontroller =TextEditingController();
  final formkey = GlobalKey<FormState>();
  late ForgetBloc forgetBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 3))..repeat();
    forgetBloc = ForgetBloc(getIt());
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => forgetBloc,
  child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DesignCustomContainer(title: "Forget Password",widget: Text("Send Email",style: TextStyle(fontSize: 25,fontFamily: "semibold",color: Colors.white),),),
              SizedBox(height: 40,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 38),
              child: Form(
                key: formkey,
                  child: Column(
                children: [
                  BlocBuilder<ForgetBloc, ForgetStates>(
                    builder: (context, state) {
                      return CustomTextfieldwidget(controller:emailcontroller
                      , label: "Email",icon: Icon(Icons.account_circle_rounded),
                        func: (value)=>context.read<ForgetBloc>().add(AddForgetEmail(email: value)),
                        validator: (value)=>AppVallidarions.emailvallidaion(value.toString()),
                        color: Colors.white,);
          },
        ),
                  SizedBox(height: 150,),
                  ForgetPasswordActionButton(emailcontroller: emailcontroller,formkey: formkey,controller: controller,),
                  SizedBox(height: 20,),
                  AuthSocialMediaButtons(callback: (){
                    Navigator.pushReplacementNamed(context, RoutesNames.signupscreens);
                  }, buttonname: "Signup", text: "Don't have account?")

                ],
              )),)
            ],
          ),
        ),
      ),
    ),
);
  }
}

class ForgetPasswordActionButton extends StatelessWidget {
  const ForgetPasswordActionButton({super.key,required this.controller,required this.formkey,required this.emailcontroller});

  final AnimationController controller;
  final GlobalKey<FormState>formkey;
  final TextEditingController emailcontroller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetBloc, ForgetStates>(
        listener: (context, state) {
          if(state.forgetAuthStates == ForgetAuthStates.success){
            context.read<ForgetBloc>().add(ResetForgetStates());
            Navigator.pushReplacementNamed(context, RoutesNames.loginscreens);
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Login Succesfull", message: state.message);
            emailcontroller.clear();
          }else if(state.forgetAuthStates == ForgetAuthStates.failure){
            context.read<ForgetBloc>().add(ResetForgetStates());
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Login Failed", message: state.message,color: Colors.red);
            emailcontroller.clear();
          }
        },
        child: BlocBuilder<ForgetBloc, ForgetStates>(
  builder: (context, state) {
    return SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
              onPressed: (){
                if(formkey.currentState!.validate()){
                  print(state.email);
                  print(state.forgetAuthStates);
                  context.read<ForgetBloc>().add(SendEmailForgetPassword());
                }
              },
              child: BlocBuilder<ForgetBloc,ForgetStates>(builder: (context,state){
                switch(state.forgetAuthStates){
                  case ForgetAuthStates.loading:
                    return Center(
                      child: SpinKitFadingCircle(
                        controller: controller,
                        color: Colors.white,
                      ),
                    );
                  case ForgetAuthStates.success:
                  case ForgetAuthStates.failure:
                  case ForgetAuthStates.initial:
                  return Text("Login",style: TextStyle(fontSize: 24.sp,fontFamily: "bold",color: Colors.white),);
                    
                }
              })),
        );
  },
)
    );
  }
}

