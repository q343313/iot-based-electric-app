

import 'package:iot/allpaths.dart'; // Contains AppColors, UpdatedBloc, UpdatedStates, ImageBloc, ImageStates, showimagedialog, Customimagewidgets, AuthAllButtons

class GetUserImage extends StatelessWidget {
  const GetUserImage({super.key, this.radius = 100});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error loading user data: ${snapshot.error}",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text("No user data available.", style: TextStyle(color: Colors.grey)),
          );
        } else {
          final data = snapshot.data!;
          final username = data.getString("username") ?? "User Name";
          final image = data.getString("userimage") ?? ""; // Provide a default empty string
          final useremail = data.getString("email") ?? "user@example.com";
          final userbio = data.getString("userbio") ?? "No bio available. Update your profile to add one!";

          return Column(
            children: [
              SizedBox(height: 0.h), // Consistent spacing
              _UserProfileImage(radius: radius, initialImage: image),
              SizedBox(height: 5.h),
              _UserNameAndEmail(username: username, useremail: useremail),
              SizedBox(height: 15.h),
              AuthAllButtons(), // Assuming this is your logout/edit profile buttons
              SizedBox(height: 20.h),
              _UserAboutCard(title: "About User", content: userbio),
              SizedBox(height: 20.h),
              _UserAboutCard(
                title: "About App",
                content: "Our IoT-based Electricity Monitoring App is a smart, user-friendly solution designed to help users take control of their energy usage in real time. By connecting with IoT devices installed in the home or office, the app provides live tracking of electricity consumption, sends alerts for unusual spikes, and offers detailed daily, weekly, and monthly reports. With an intuitive interface and powerful insights, this app empowers users to make informed decisions, reduce energy waste, and ultimately lower their electricity bills—all while promoting a greener and more sustainable lifestyle.",
              ),
              SizedBox(height: 20.h), // Bottom spacing
            ],
          );
        }
      },
    );
  }
}

// --- Helper Widgets for GetUserImage ---

class _UserProfileImage extends StatelessWidget {
  final double radius;
  final String initialImage;

  const _UserProfileImage({
    required this.radius,
    required this.initialImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageStates>(
      builder: (context, imageState) {
        final imagePath = imageState.imagepath;
        if (imagePath != null && imagePath.path.isNotEmpty) {
          // If a new image is selected, update the UpdatedBloc
          context.read<UpdatedBloc>().add(AddUpdatedImages(image: imagePath.path));
        }
        return InkWell(
          onTap: () {
            showimagedialog(context); // Assuming this function exists globally
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Customimagewidgets(
                image: imagePath != null && imagePath.path.isNotEmpty
                    ? imagePath.path
                    : initialImage,
                radius: radius,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 24.w, // Responsive icon size
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  final String username;
  final String useremail;

  const _UserNameAndEmail({
    required this.username,
    required this.useremail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          username,
          style: TextStyle(
            fontSize: 24.sp, // Responsive font size
            fontFamily: "bold", // Ensure this font family is loaded
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineMedium?.color,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 0.h),
        Text(
          useremail,
          style: TextStyle(
            color: Colors.purple.shade400, // A more muted purple
            fontSize: 12.sp, // Responsive font size
            fontFamily: "semibold", // Ensure this font family is loaded
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _UserAboutCard extends StatelessWidget {
  final String title;
  final String content;

  const _UserAboutCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDarkMode ? AppColors.textfielddarkmode : const Color(0XFF009688); // Use your AppColors.textfielddarkmode

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.w), // Responsive horizontal margin
      elevation: 6, // Slightly more elevation for a lift effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r), // Responsive border radius
        side: BorderSide(color: Colors.white12), // Subtle border
      ),
      color: cardColor,
      child: Padding(
        padding: EdgeInsets.all(18.w), // Responsive padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: "bold",
                fontSize: 20.sp, // Responsive font size
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              content,
              style: TextStyle(
                fontSize: 14.sp, // Responsive font size, slightly smaller for body
                color: Colors.white70, // Slightly muted white for readability
                height: 1.5, // Line height for better readability
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}