import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';
import 'package:softec/firebase_options.dart';
import 'package:softec/providers/authentication_provider.dart';
import 'package:softec/router/router.dart';
import 'package:softec/router/routes.dart';
import 'package:softec/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final navigatorKey = GlobalKey<NavigatorState>();
  final List<NavigatorObserver> observers = [];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // BlocProvider(create: (context) => JobBloc()),
        ChangeNotifierProvider<SplashScreenStateProvider>(
          create: (context) => SplashScreenStateProvider(),
        ),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (context) => AuthenticationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        navigatorObservers: [...observers, NavigationHistoryObserver()],
        title: 'Flutter Demo',
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
            // selectedItemColor: Colors.white,
            // unselectedItemColor: Colors.white54,
          ),

          scaffoldBackgroundColor: Color.fromRGBO(35, 35, 49, 1),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: DashboardScreen(),
        onGenerateRoute: onGenerateRoutes,
        routes: appRoutes,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
