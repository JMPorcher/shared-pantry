// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getBool('user signed in anonymously before') == true) {
    FirebaseAuth.instance.signInAnonymously();
    //This should anonymously sign in the user if they have been signed in anonymously before
    //TODO: What's missing is that this is only important if the user has not registered an account. Maybe the whole thing should be handled through the AuthProvider?
  }

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
          builder: (BuildContext context, AsyncSnapshot snapshot)  {
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

Future<bool> isFirstTime() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isFirstTime = sharedPreferences.getBool('is first time') ?? true;
  return isFirstTime;
}

Future<void> setFirstTimeFlagToFalse() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('is first time', false);
}

Future<bool> userSignedInAnonymouslyBefore() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool hasSignedInBefore = sharedPreferences.getBool('has signed in before') ?? true;
  return hasSignedInBefore;
}

Future<void> setUserSignedInBeforeToFalse() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('has signed in before', false);
}