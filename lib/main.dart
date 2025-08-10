
import 'package:iot/allpaths.dart';
import 'package:iot/data/appnotifications/appnotifications.dart';

GetIt getIt = GetIt.instance;
void main()async{
  await initializednotifications();
  allinjections();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>ThemeCubits()),
      BlocProvider(create: (_)=>DefaultBloc()),
      BlocProvider(create: (_)=>ImageBloc(getIt())),
      BlocProvider(create: (_)=>SignupBloc(getIt())),
      BlocProvider(create: (_)=>LoginBloc(getIt())),
      BlocProvider(create: (_)=>UpdatedBloc())
    ],
        child: BlocBuilder<ThemeCubits,ThemeStates>(builder: (context,state){
          return ScreenUtilInit(
            designSize: const Size(360, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context,child){
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state is LightThemeStates?AppThemes.lightthemedata:AppThemes.darkthemedata,
                title: "IOT ELECTRIC",
                initialRoute: RoutesNames.splashscreens,
                onGenerateRoute: Routes.generateroute,
              );
            },
          );
        }));
  }
}

void allinjections(){
  getIt.registerLazySingleton<ImageRepository>(()=>ImageRepository());
  getIt.registerLazySingleton<AuthenticationImplementations>(()=>AuthenticationImplementations());
}