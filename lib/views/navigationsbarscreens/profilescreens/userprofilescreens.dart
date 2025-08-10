import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:iot/allpaths.dart'; // This should contain definitions for AppColors, UpdatedBloc, UpdatedStates, ImageBloc, ImageStates, showimagedialog, Customimagewidgets, AuthAllButtons
import 'package:iot/data/appnotifications/appnotifications.dart'; // Contains shownotifications function

class Userprofilescreens extends StatefulWidget {
  const Userprofilescreens({super.key});

  @override
  State<Userprofilescreens> createState() => _UserprofilescreensState();
}

class _UserprofilescreensState extends State<Userprofilescreens> {
  late UpdatedBloc updatedBloc;

  @override
  void initState() {
    super.initState();
    updatedBloc = UpdatedBloc();
  }

  @override
  void dispose() {
    updatedBloc.close(); // Dispose the bloc
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => updatedBloc,
      child: Scaffold(
        body: SafeArea( // Use SafeArea to avoid system overlays
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w, // Responsive horizontal padding
              vertical: 20.h,   // Responsive vertical padding
            ),
            child: Center(
              child: Column(
                children: [
                  GetUserImage(), // Your main content widget
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 16.h, right: 10.w), // Add some padding
          child: FloatingActionButton(
            onPressed: () {
              // AuthenticationImplementations().chatwithwhatsapp(); // Uncomment if needed
              shownotifications(
                title: 'Talha Afridi',
                body: 'Hey, this message is coming from the Flutter app!',
                categry: NotificationCategory.Workout,
                notificationlayout: NotificationLayout.MediaPlayer,
              );
            },
            backgroundColor: Colors.green.shade700,
            shape: const CircleBorder(), // Make it a perfect circle
            elevation: 8.0, // WhatsApp green
            child: Image.asset(
              "assets/images/what.png",
              width: 30.w, // Responsive image size
              height: 30.h,
            ), // Add some shadow
          ),
        ),
      ),
    );
  }
}