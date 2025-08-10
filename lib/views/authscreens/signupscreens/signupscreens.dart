import 'package:iot/allpaths.dart';


class Signupscreens extends StatefulWidget {
  const Signupscreens({super.key});

  @override
  State<Signupscreens> createState() => _SignupscreensState();
}
class _SignupscreensState extends State<Signupscreens>with TickerProviderStateMixin {
  late AnimationController controller;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 3))..repeat();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                DesignCustomContainer(title: "Create Account"),
        
                SizedBox(height: 40,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 38),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        CustomTextfieldwidget(
                          controller: emailcontroller,
                          label: 'Email',
                          validator: (value)=>AppVallidarions.emailvallidaion(value.toString()),
                          func: (value)=>context.read<SignupBloc>().add(AddSignupEmail(email: value)),
                          color: Colors.white,
                          icon: Icon(Icons.email, color: Colors.white,),
                        ),
                        SizedBox(height: 10.h,),
                        BlocBuilder<DefaultBloc, DefaultStates>(
                          builder: (context, state) {
                            return CustomTextfieldwidget(
                              obstractext: state.showpassword,
                              controller: passwordcontroller,
                              validator: (value)=>AppVallidarions.passwordvallidation(value.toString()),
                              func: (value)=>context.read<SignupBloc>().add(AddSignupPassword(password: value)),
                              label: 'Password',
                              suffixixon: IconButton(onPressed: (){
                                context.read<DefaultBloc>().add(ShowHidePassword());
                              }, icon: Icon(state.showpassword?Icons.visibility:Icons.visibility_off,color: Colors.white,)),
                              color: Colors.white,
                              icon: Icon(Icons.password, color: Colors.white,),
                            );
                          },
                        ),
                        SignupCheckBoxWidget(),
                        SizedBox(height: 40.h,),
                        SignupActionButton(formkey: _formkey,controller: controller,emailcontroller: emailcontroller,passwordcontroller: passwordcontroller,),
                        SizedBox(height:10.h),
                        AuthSocialMediaButtons(
                          callback: (){
                          Navigator.pushNamed(context, RoutesNames.loginscreens);
                        },text: "Already have account?",buttonname: "Login",)
        
                      ],
                    ),
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}










