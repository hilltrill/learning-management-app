import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learning_management_app/models/cart_model.dart';
import 'package:learning_management_app/models/cart_provider.dart';
import 'package:learning_management_app/screens/auth_screen.dart';
import 'package:learning_management_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';

import 'screens/dashboard_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthHandler(),
      routes: {
        DashboardScreen.routeName: (context) => DashboardScreen(),
        MainScreen.routeName: (context) => MainScreen(),
        CatalogScreen.routeName: (context) => CatalogScreen(),
      },
    );
  }
}

class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If the user is authenticated, show the WelcomeScreen
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return const AuthScreen();
            } else {
              return const WelcomeScreen();
            }
          }

          // While the FirebaseAuth stream is loading, show a loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
