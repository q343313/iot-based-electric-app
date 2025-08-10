import 'package:iot/allpaths.dart';

class Updateduseerprofiles extends StatefulWidget {
  const Updateduseerprofiles({super.key});

  @override
  State<Updateduseerprofiles> createState() => _UpdateduseerprofilesState();
}

class _UpdateduseerprofilesState extends State<Updateduseerprofiles> {

   TextEditingController usernamecontroller = TextEditingController();
   TextEditingController userbiocontroller = TextEditingController();
   final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(future:SharedPreferences.getInstance(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else {
                          final data  = snapshot.data!;
                          final username = data.getString("username").toString();
                          final image = data.getString("userimage").toString();
                          final userbio = data.getString("userbio").toString();

                          WidgetsBinding.instance.addPostFrameCallback((_){
                            usernamecontroller.text  =username;
                            userbiocontroller.text = userbio;
                          });
                          return Column(
                            children: [
                              SizedBox(height: 80.h,),
                              BlocBuilder<UpdatedBloc, UpdatedStates>(
                                builder: (context, states) {
                                  return BlocBuilder<UpdatedBloc, UpdatedStates>(
                                    builder: (context, state) {
                                      return BlocBuilder<ImageBloc,ImageStates>(builder: (context,state){
                                        final imagepath = state.imagepath;
                                        if(imagepath != null && imagepath.path.isNotEmpty){
                                          context.read<UpdatedBloc>().add(AddUpdatedImages(image: imagepath.path));
                                        }
                                        return InkWell(
                                          onTap: (){
                                            showimagedialog(context);
                                          },
                                          child:imagepath != null && imagepath.path.isNotEmpty?
                                          Customimagewidgets(image: imagepath.path.toString(),radius: 100,):
                                          Customimagewidgets(image: image,radius: 100,),
                                        );
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      }),

                  SizedBox(height: 20.h,),
                  CustomTextfieldwidget(
                    controller: usernamecontroller,
                    label: "",
                    color: Colors.white,
                    icon: Icon(Icons.account_circle_rounded),
                    validator: (value)=>AppVallidarions.usernamevallidation(value.toString()),
                    func: (value)=>context.read<UpdatedBloc>().add(AddUpdatedUsername(username: value)),
                  ),
                  SizedBox(height: 10.h,),
                  CustomTextfieldwidget(
                    controller: userbiocontroller,
                    color: Colors.white,
                    icon: Icon(Icons.description),
                    // validator: (value)=>AppVallidarions.userbiovallidation(value.toString()),
                    func: (value)=>context.read<UpdatedBloc>().add(AddUpdatedUserbio(userbio: value)),
                    label: "",),
                  SizedBox(height: 90,),
                  UpdatedActionButton(formkey: formkey,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class UpdatedActionButton extends StatelessWidget {
  const UpdatedActionButton({super.key,required this.formkey});
  final GlobalKey<FormState>formkey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(onPressed: (){
        if(formkey.currentState!.validate()){
          context.read<UpdatedBloc>().add(UpdatedUserProfile());
          Navigator.pushReplacementNamed(context, RoutesNames.homescreen);
        }
      }
          , child: Text("Updated Profile",style: TextStyle(fontFamily: "bold",fontSize: 23,color: Colors.white),)),
    );
  }
}
