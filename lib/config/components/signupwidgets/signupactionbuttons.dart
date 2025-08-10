


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iot/bloc/signupbloc/signupbloc.dart';
import 'package:iot/config/components/customsnakebarwidgets.dart';
import 'package:iot/config/routes/routenames.dart';
import 'package:iot/utils/controllers.dart';
import 'package:iot/utils/enums.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SignupActionButton extends StatelessWidget {
  SignupActionButton({super.key,required this.formkey,required this.controller,required this.emailcontroller,required this.passwordcontroller});

  final AppControllers appControllers  = AppControllers();
  final GlobalKey<FormState>formkey;
  final AnimationController controller;
  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupStates>(
        listener: (context, state) {
          if(state.signupAuthStates == SignupAuthStates.profile){
            context.read<SignupBloc>().add(AgainInitial());
            Navigator.pushReplacementNamed(context, RoutesNames.addprofiledata);
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Signup Successfully", message: state.message);
            emailcontroller.clear();
            passwordcontroller.clear();
          }else if(state.signupAuthStates == SignupAuthStates.exists){
            context.read<SignupBloc>().add(AgainInitial());
            Navigator.pushReplacementNamed(context, RoutesNames.loginscreens);
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Already Exists", message: state.message,color: Colors.orange);
            emailcontroller.clear();
            passwordcontroller.clear();
          }else if(state.signupAuthStates == SignupAuthStates.failure){
            context.read<SignupBloc>().add(AgainInitial());
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Signup Failed", message: state.message,color: Colors.red);
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
                  final checkbox = context.read<SignupBloc>().state;
                  print(checkbox.email);
                  print(checkbox.password);
                  if(checkbox.checkbox == false){
                    CustomSnackbarWidets.awesoemsnackbarwidget(context: context, title: "Warnings", message: "Please fill the checkbox", contentType: ContentType.warning);
                  }else{
                    context.read<SignupBloc>().add(CreateUserAccount());
                  }
                }
              },
              child: BlocBuilder<SignupBloc,SignupStates>(builder: (context,state){
                switch(state.signupAuthStates){
                  case SignupAuthStates.loading:
                    return Center(
                      child: SpinKitFadingCircle(
                        controller: controller,
                        color: Colors.white,
                      ),
                    );
                  case SignupAuthStates.success:
                  case SignupAuthStates.failure:
                  case SignupAuthStates.exists:
                  case SignupAuthStates.initial:
                  case SignupAuthStates.profile:
                    return Text("Signup",style: TextStyle(fontSize: 24.sp,fontFamily: "bold",color: Colors.white),);
                }
              })
          ),
        ));
  }
}



class ProfileActionButton extends StatelessWidget {
  ProfileActionButton({super.key,required this.formkey,required this.controller,required this.userbiocontroller,required this.usernamecontroller});

  final GlobalKey<FormState>formkey;
  final AnimationController controller;
  final TextEditingController usernamecontroller;
  final TextEditingController userbiocontroller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupStates>(
        listener: (context, state) {
          if(state.signupAuthStates == SignupAuthStates.success){
            context.read<SignupBloc>().add(AgainInitial());
            Navigator.pushReplacementNamed(context, RoutesNames.homescreen);
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Profile Successfully", message: state.message);
            userbiocontroller.clear();
            userbiocontroller.clear();
          }else if(state.signupAuthStates == SignupAuthStates.failure){
            context.read<SignupBloc>().add(AgainInitial());
            CustomSnackbarWidets.flusbarsnackbar(context: context, title: "Profile Failed", message: state.message,color: Colors.red);
            userbiocontroller.clear();
            userbiocontroller.clear();
          }
        },
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              onPressed: (){

                if(formkey.currentState!.validate()){
                  final checkbox = context.read<SignupBloc>().state;
                    context.read<SignupBloc>().add(CreateUserProfile());
                }
              },
              child: BlocBuilder<SignupBloc,SignupStates>(builder: (context,state){
                switch(state.signupAuthStates){
                  case SignupAuthStates.loading:
                    return Center(
                      child: SpinKitFadingCircle(
                        controller: controller,
                        color: Colors.white,
                      ),
                    );
                  case SignupAuthStates.success:
                  case SignupAuthStates.failure:
                  case SignupAuthStates.exists:
                  case SignupAuthStates.initial:
                  case SignupAuthStates.profile:
                    return Text("Create Profile",style: TextStyle(fontSize: 24.sp,fontFamily: "bold",color: Colors.white),);
                }
              })
          ),
        ));
  }
}