import 'package:iot/allpaths.dart';

class Profilescreens extends StatefulWidget {
  const Profilescreens({super.key});

  @override
  State<Profilescreens> createState() => _ProfilescreensState();
}

class _ProfilescreensState extends State<Profilescreens> with TickerProviderStateMixin{
  late AnimationController controller;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController userbiocontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 3))..repeat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DesignCustomContainer(
                title: "Add Profile",
                widget: BlocBuilder<ImageBloc, ImageStates>(
                  builder: (context, state) {
                    final imagepath  = state.imagepath;
                    if(imagepath != null && imagepath.path.isNotEmpty){
                      context.read<SignupBloc>().add(AddUserImage(userimage: imagepath.path.toString()));
                    }
                    return InkWell(
                      onTap: (){
                        showimagedialog(context);
                      },
                        child:imagepath != null && imagepath.path.isNotEmpty?
                            Customimagewidgets(image: imagepath.path.toString(),)
                        :Customimagewidgets());
                  },
                ),
              ),
        
              SizedBox(height: 80,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 38),
              child: Form(
                key: formkey,
                  child: Column(
                children: [
                  CustomTextfieldwidget(controller:usernamecontroller ,
                      label: "UserName",
                    color: Colors.white,
                    validator: (value)=>AppVallidarions.usernamevallidation(value.toString()),
                    func: (value)=>context.read<SignupBloc>().add(AddUserName(username: value)),
                    icon: Icon(Icons.account_circle_rounded),
                  ),
                  SizedBox(height: 10.h,),
                  CustomTextfieldwidget(controller:userbiocontroller ,
                    label: "UserBio",
                    color: Colors.white,
                    validator: (value)=>AppVallidarions.userbiovallidation(value.toString()),
                    func: (value)=>context.read<SignupBloc>().add(AddUserBio(userbio: value)),
                    icon: Icon(Icons.description),
                  )
                ],
              )),)
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: ProfileActionButton(
          formkey: formkey,
          usernamecontroller: usernamecontroller,
          userbiocontroller: userbiocontroller,
          controller: controller,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
