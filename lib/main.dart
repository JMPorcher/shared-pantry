// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pantry/providers/auth_provider.dart';
import 'package:shared_pantry/providers/pantry_list_provider.dart';
import 'package:shared_pantry/widgets/first_startup_screen.dart';
import 'package:shared_pantry/widgets/pantry_screen.dart';
import 'package:shared_pantry/widgets/profile_screen.dart';
import 'package:shared_pantry/widgets/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PantryProvider()),
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      )
    ],
    child: const SharedPantry(),
  ));
}

class SharedPantry extends StatelessWidget {
  const SharedPantry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shared Pantry',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<bool>(
          future: isFirstTime(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == true) {
              setFirstTimeFlagToFalse();
              return const FirstStartupScreen();
            }
            else {
              return const PantryScreen();
            }
          },
        ),

        //const PantryScreen(),
        routes: {
          ProfileScreen.id: (context) => const ProfileScreen(),
          SignupScreen.id: (context) => const SignupScreen(),
          PantryScreen.id: (context) => const PantryScreen(),
        });
  }
}

Future<bool> isFirstTime() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isFirstTime = sharedPreferences.getBool('is first time') ?? true;
  return isFirstTime;
}

Future<void> setFirstTimeFlagToFalse() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //await sharedPreferences.setBool('is first time', false);
}