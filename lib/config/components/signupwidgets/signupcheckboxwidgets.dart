



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/bloc/signupbloc/signupbloc.dart';

class SignupCheckBoxWidget extends StatelessWidget {
  const SignupCheckBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupStates>(
      buildWhen: (prievies,current)=>prievies.checkbox != current.checkbox,
      builder: (context, state) {
        return InkWell(
          onTap: (){
            context.read<SignupBloc>().add(EnableCheckBox());
          },
          child: Row(
            children: [
              Checkbox(value: state.checkbox,
                  onChanged: (value){}),
              Wrap(
                  children:[
                    Text("I accept all term,condition and privacy\npolicy of this app.",style: TextStyle(color: Colors.white),)])
            ],
          ),
        );
      },
    );
  }
}