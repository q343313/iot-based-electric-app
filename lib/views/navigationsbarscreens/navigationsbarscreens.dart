import 'package:iot/allpaths.dart';


class Navigationsbarscreens extends StatefulWidget {
  const Navigationsbarscreens({super.key});

  @override
  State<Navigationsbarscreens> createState() => _NavigationsbarscreensState();
}

class _NavigationsbarscreensState extends State<Navigationsbarscreens> {

  var index = 0;
  List<Widget>screens = [
    Graphscreens(),
    Hubscreens(),
    Userprofilescreens()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: WidgetStateProperty.all(
           IconThemeData(
             color: Colors.white,
           ),
          )
        ),
        child: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.graphic_eq_outlined), label: "Dashboard",selectedIcon: Icon(Icons.auto_graph),),
            NavigationDestination(icon: Icon(Icons.hub), label: "Hub",selectedIcon: Icon(Icons.hub),),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile",selectedIcon: Icon(Icons.person),)
          ],
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(color: Colors.white)
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textfielddarkmode
          : Colors.white12,
          indicatorColor: Colors.blue.shade100,
          shadowColor: Colors.white,
          elevation: Theme.of(context).brightness == Brightness.dark
              ? 0
              : 30,
          height: 60,
          selectedIndex: index,
          onDestinationSelected: (value){
            setState(() {
              index  = value;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: index,
        children: screens,
      ),
    );
  }
}
